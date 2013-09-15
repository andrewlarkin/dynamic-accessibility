class Task < ActiveRecord::Base
  validates :name, :is_active, :presence => true
  validates :name, :uniqueness => { :case_sensitive => false }
end
