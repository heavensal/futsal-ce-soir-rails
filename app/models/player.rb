class Player < ApplicationRecord
  belongs_to :event
  belongs_to :team
  belongs_to :user
  validates :event_id, presence: true
  validates :team_id, presence: true
  validates :user_id, presence: true
end
