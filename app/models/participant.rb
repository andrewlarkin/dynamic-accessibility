class Participant < ActiveRecord::Base

  validates :email, :uniqueness => { :case_sensitive => false }
  validates :device, :inclusion => { :in => ['smartphone', 'tablet', 'desktop', 'other'] }
  validates :age, :numericality => { :only_integers => true }
  validates :tech_ability, :numericality => { :only_integers => true }
  validates :tech_ability, :inclusion => { :in => 1..5 }
  validates :prof_level, :numericality => { :only_integers => true }, :allow_nil => true
  # add email validation

  has_many :completed_tasks
end
