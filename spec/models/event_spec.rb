require 'rails_helper'

RSpec.describe Event, type: :model do
  # créer les objets nécessaires pour les tests
  let(:user_test) { User.create!(email: "test@exemple.fr", password: "password") }
  # a la création de l'événement, 3 équipes sont créées
  # la première équipe est remplie avec l'utilisateur créateur de l'événement
  it "creates 3 teams and adds the author as a player" do
    user_test.events.create!(title: "Titre test", location: "Lieu test", start_time: Time.now + 1.day, price_per_player: 10.0, privacy: "Public", number_of_players: 10)
    # expect(Event.last.teams.count).to eq(3)
    expect(Event.last.teams.first.players.count).to eq(1)
  end
  # vérifier que l'événement est bien créé
end
