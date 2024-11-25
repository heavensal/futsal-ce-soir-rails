class Event < ApplicationRecord
  belongs_to :user
  has_many :players, dependent: :destroy
  has_many :teams, dependent: :destroy

  validates :user_id, presence: true
  validates :title, presence: true
  validates :privacy, presence: true, inclusion: { in: [ "Privé", "Public" ] }

  after_create :create_teams_and_add_author

  def create_teams_and_add_author
    team_1 = self.teams.create!(name: "Equipe 1")
    team_1.players.create!(user: self.user, event: self)
    self.teams.create!(name: "Equipe 2")
    self.teams.create!(name: "Sur le Banc")
  end
end
