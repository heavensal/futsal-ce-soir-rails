class Team < ApplicationRecord
  belongs_to :event
  has_many :players, dependent: :destroy
end
