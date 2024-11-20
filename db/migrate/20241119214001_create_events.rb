class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :title, null: false, default: ""
      t.string :location, null: false, default: ""
      t.datetime :start_time, null: false, default: Time.now + 1.day
      t.float :price_per_player, null: false, default: 10.0
      t.string :privacy, null: false, default: "public"
      t.integer :number_of_players, null: false, default: 10
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
