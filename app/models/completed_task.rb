class CompletedTask < ActiveRecord::Base
  belongs_to :participant
  belongs_to :task

  validates :participant_id, :task_id, :time, :error_rate, :presence => true
  validates :success_rate, :numericality => { :less_than_or_equal_to => 100, :greater_than_or_equal_to => 0 } # succsss rate is a percentage
  validates :subjective_rating, :numericality => { :less_than_or_equal_to => 5, :greater_than_or_equal_to => 1 }, :allow_nil => true

  def self.by_participant
    where(:participant_id => current_particpant.id)
  end
end
