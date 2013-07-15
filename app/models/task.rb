class Task < ActiveRecord::Base
  has_many :completed_tasks
  belongs_to :task_set

  validates :type, :description, :task_set_id, presence: true
  validates :type, inclusion: ['a', 'b', 'c', 'd']
end
