class CompletedTask < ActiveRecord::Base
  belongs_to :participant
  belongs_to :task

  validates :participant_id, :task_id, :time, :error_rate, :presence => true
  validates :success_rate, :inclusion => [0..100] # succsss rate is a percentage
  validates :subjective_rating, :inclusion => [1..5]

  # named_scope :by_participant, lambda {|participant| { :conditions => { :participant_id => participant.id }}}
  def self.by_participant
    where(:participant_id => current_particpant.id)
  end
end
