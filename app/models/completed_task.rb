class CompletedTask < ActiveRecord::Base
  belongs_to :participant
  belongs_to :task
  has_many :error_rates

  validates :participant_id, :task_id, :rating, :completed, :time, :success_rate, presence: true
  validates :rating, inclusion: [1..5]
end
