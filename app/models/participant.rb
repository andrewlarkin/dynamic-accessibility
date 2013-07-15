class Participant < ActiveRecord::Base
  attr_accessible :email, :disability, :tech_ability, :device

  validates :email, :device, presence: true
  validates :email, :username, uniqueness: { case_sensitive: false }
  validates :device, inclusion: ['android', 'ipad', 'iphone', 'macos', 'windows', 'kindle fire']
  # consider adding a :device_version field
  validates :prof_level, numericality: { only_integers: true, allow_nil: true }
  # add email validation

  has_many :completed_tasks
end
