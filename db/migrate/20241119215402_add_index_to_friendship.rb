class AddIndexToFriendship < ActiveRecord::Migration[8.0]
  def change
    add_index :friendships, [ :user_id, :friend_of_id ], unique: true
  end
end
