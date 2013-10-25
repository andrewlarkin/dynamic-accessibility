class Score < ActiveRecord::Base
  belongs_to :participants

  validates :participant_id, :type, :presence => true
  validates :score, :numericality => { :only_integers => true }
  validates :score, :inclusion => { :in => 0..4 }

  scope :by_type, ->(type) { where(type: type)}
end