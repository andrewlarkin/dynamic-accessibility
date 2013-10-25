class Task < ActiveRecord::Base
  validates :name, :is_active, :presence => true
  validates :name, :uniqueness => { :case_sensitive => false }

  has_many :completed_tasks
  has_many :participants, :through => :completed_tasks

  has_one :next, { :class_name => "Task", :foreign_key => "prereq_id"}
  belongs_to :prereq, { :class_name => "Task" }
end
