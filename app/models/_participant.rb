class Participant < ActiveRecord::Base
  has_many :completed_tasks

  validates :email, :tech_ability, :device, presence: true
  validates :email, :username, uniqueness: { case_sensitive: false }
  #TODO: Add email validation

  #TODO: Add a validator to check password if email is present
  validates :prof_level, numerality: { in: 1..4, allow_nil: true }, :message => "Proficiency level must be a numeric value."
end


