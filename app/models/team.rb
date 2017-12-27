class Team < ApplicationRecord
  has_many :players
  
  validates :title, presence: true
end
