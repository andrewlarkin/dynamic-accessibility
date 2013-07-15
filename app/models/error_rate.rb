class ErrorRate < ActiveRecord::Base
  belongs_to :completed_task

  validates :completed_task_id, :error_id, :error_rate, presence: true
  validates :error_rate, numericality: { only_integers: true }
end
