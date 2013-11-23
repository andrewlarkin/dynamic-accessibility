class Score < ActiveRecord::Base
  belongs_to :participants

  validates :participant_id, :activity_type, :presence => true
  validates :score, :numericality => { :only_integers => true }
  validates :score, :inclusion => { :in => 0..4 }

  scope :by_type, ->(type) { where(activity_type: type)}
end