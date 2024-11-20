class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend_of
  has_many :players, dependent: :destroy
  has_many :teams, through: :players
end
