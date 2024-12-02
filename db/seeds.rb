# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create 5 users for testing friendships
# user = User.create!(email: 'johnkennedy@1344.fr', password: '123456', first_name: 'John', last_name: 'Kennedy')
# puts "User #{user.first_name} created !"

# user = User.create!(email: 'leilachabba@1344.fr', password: '123456', first_name: 'Leila', last_name: 'Chabba')
# puts "User #{user.first_name} created !"

# user = User.create!(email: 'mohamedali@1344.fr', password: '123456', first_name: 'Mohamed', last_name: 'Ali')
# puts "User #{user.first_name} created !"

# user = User.create!(email: 'judebellingham@1344.fr', password: '123456', first_name: 'Jude', last_name: 'Bellingham')
# puts "User #{user.first_name} created !"

# user = User.create!(email: 'karimbenzema@1344.fr', password: '123456', first_name: 'Karim', last_name: 'Benzema')
# puts "User #{user.first_name} created !"

# puts "5 users created !"

# Create 5 friendships for testing friendships
friendship = Friendship.create!(user: User.second, friend_of: User.first, status: "accepted")
puts "Friendship between #{friendship.user.first_name} and #{friendship.friend_of.first_name} created !"

friendship = Friendship.create!(user: User.third, friend_of: User.first, status: "pending")
puts "Friendship between #{friendship.user.first_name} and #{friendship.friend_of.first_name} created !"

friendship = Friendship.create!(user: User.first, friend_of: User.all[3], status: "accepted")
puts "Friendship between #{friendship.user.first_name} and #{friendship.friend_of.first_name} created !"

friendship = Friendship.create!(user: User.first, friend_of: User.all[4], status: "pending")
puts "Friendship between #{friendship.user.first_name} and #{friendship.friend_of.first_name} created !"

friendship = Friendship.create!(user: User.all[5], friend_of: User.first, status: "accepted")
puts "Friendship between #{friendship.user.first_name} and #{friendship.friend_of.first_name} created !"

puts "5 friendships created !"
