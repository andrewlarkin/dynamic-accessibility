class Error < ActiveRecord::Base
  belongs_to :error_rate

  validates :selector, presence: true
  validates :selector, uniqueness: true
end
