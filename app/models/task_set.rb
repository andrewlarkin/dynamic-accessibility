class TaskSet < ActiveRecord::Base
  has_many :tasks

  validates :name, :is_active, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
