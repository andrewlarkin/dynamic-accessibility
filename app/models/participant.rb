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
    value = self.completed_tasks.type(type).average(metric)
    larger = []
    smaller = []

    Participant.selected.each do | p |
      if (p.id != self.id)
        v = p.completed_tasks.type(type).average(metric)

        if v >= value
          larger.push(v)
        else
          smaller.push(v)
        end
      end
    end

    percentile = smaller.size / larger.size + smaller.size

    if percentile == 1
      return 4
    elsif percentile >= 0.75
      return 3
    elsif percentile >= 0.5
      return 2
    elsif percentile >= 0.25
      return 1
    else
      return 0
    end
  end

  def correctness_quartile(metric, type)
    value = self.completed_tasks.type(type).average(metric)
    larger = []
    smaller = []

    Participant.selected.each do | p |
      if (p.id != self.id)
        v = p.completed_tasks.type(type).average(metric)

        if v >= value
          larger.push(v)
        else
          smaller.push(v)
        end
      end
    end

    percentile = smaller.size / larger.size + smaller.size

    if percentile == 1
      return 0
    elsif percentile >= 0.75
      return 1
    elsif percentile >= 0.5
      return 2
    elsif percentile >= 0.25
      return 3
    else
      return 4
    end
  end

  def set_level(type)
    error_quart = self.quartile('error_rate', type)
    correctness_quart = self.correctness_quartile('correctness', type)
    time_quart = self.quartile('time', type)

    avg = (error_quart + correctness_quart + time_quart) / 3
    current_score = self.scores.by_type(type).first()

    if (avg == 4)
      score = 0
    elsif (avg > 3)
      score = 1
    elsif (avg > 2)
      score = 2
    elsif (avg > 1)
      score = 3
    else
      score = 4
    end

    if score > current_score.score
      Scores.update(current_score.id, :score => score)
    end
  end

  def level(type)
    puts(self.scores)

    score = self.scores.by_type(type).first()

    return score.nil? ? 0 : score.score
  end
end
