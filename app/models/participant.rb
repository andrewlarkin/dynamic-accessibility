class Participant < ActiveRecord::Base

  validates :email, :uniqueness => { :case_sensitive => false }
  validates :device, :inclusion => { :in => ['smartphone', 'tablet', 'desktop', 'other'] }
  validates :age, :numericality => { :only_integers => true }
  validates :tech_ability, :numericality => { :only_integers => true }
  validates :tech_ability, :inclusion => { :in => 1..5 }
  # add email validation

  has_many :completed_tasks
  has_many :scores
  has_many :tasks, :through => :completed_tasks

  acts_as_authentic do |c|
    c.logged_in_timeout = 24.hours
  end

  scope :selected, -> { where(is_selected: true) }

  def self.avg_by_activity(metric, task_id, activity_id)
    avg = 0
    total = 0
    length = 0

    Participant.selected.each do | p |
      v = p.completed_tasks.where(:task_id => task_id, :activity_id => activity_id).first()[metric]
      if (v > 0)
        total += v
        length += 1
      end
    end
    if length > 0
      avg = total / length
    end

    avg
  end

  def self.quartile_by_activity(metric, task_id, activity_id)
    values = []

    Participant.selected.each do | p |
      v = p.completed_tasks.where(:task_id => task_id, :activity_id => activity_id).first()[metric]
      if (!v.nil?)
        values.push(v)
      end
    end

    values.sort

    #pass in the user's id
    #find position
  end

  def quartile(metric, type)
    value = self.completed_tasks.by_type(type).average(metric)
    larger = []
    smaller = []

    puts type, value

    Participant.selected.each do | p |
      if (p.id != self.id)
        v = p.completed_tasks.by_type(type).average(metric)

        puts v

        if v >= value
          larger.push(v)
        else
          smaller.push(v)
        end
      end
    end

    total = larger.size + smaller.size

    puts smaller.size
    puts larger.size

    puts total

    if total == 0
      return 4
    elsif (total > 0) 

      if type == 'success_rate'
        percentile = larger.size / total
      else
        percentile = smaller.size / total
      end

      puts percentile

      if percentile == 0
        return 4
      elsif percentile <= 0.25
        return 3
      elsif percentile <= 0.5
        return 2
      elsif percentile <= 0.75
        return 1
      else
        return 0
      end
    else 
      return 0
    end
  end

  def correctness_quartile(type)
    value = self.completed_tasks.by_type(type).average('success_rate')
    larger = []
    smaller = []

    Participant.selected.each do | p |
      if (p.id != self.id)
        v = p.completed_tasks.by_type(type).average('success_rate')

        if v > value
          larger.push(v)
        else
          smaller.push(v)
        end
      end
    end

    total = larger.size + smaller.size

    if total == 0
      return 4
    elsif (total > 0) 

      percentile = larger.size / total

      if percentile == 0
        return 4
      elsif percentile <= 0.25
        return 3
      elsif percentile <= 0.5
        return 2
      elsif percentile <= 0.75
        return 1
      else
        return 0
      end
    else 
      return 0
    end
  end

  def set_level(type)
    error_quart = self.quartile('error_rate', type)
    correctness_quart = self.quartile('success_rate', type)
    time_quart = self.quartile('time', type)

    puts error_quart
    puts correctness_quart
    puts time_quart

    avg = (error_quart + correctness_quart + time_quart) / 3
    current_score = self.scores.by_type(type).first()

    if current_score.nil?
      current_score = Score.new({
        :participant_id => self.id,
        :activity_type => type,
        :score => avg < 2 ? 1 : 0
      })

      current_score.save
    elsif avg < 2 && current_score.score < 4
      Score.update(current_score.id, :score => current_score.score + 1)
    end
  end

  def level(type)
    score = self.scores.by_type(type).first()

    return score.nil? ? 0 : score.score
  end
end
