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

  after_create :set_username

  def set_username
    self.username = "#{self.first_name}#{self.last_name}##{rand(1000..9999)}"
  end

  def friends
    # IDs des amis où l'utilisateur est le demandeur
    friend_ids_as_user = Friendship.where(user: self, status: "accepted").pluck(:friend_of_id)
    # IDs des amis où l'utilisateur est l'ami
    friend_ids_as_friend = Friendship.where(friend_of: self, status: "accepted").pluck(:user_id)
    # Union des deux listes et suppression des doublons
    friend_ids = friend_ids_as_user + friend_ids_as_friend
    User.where(id: friend_ids.uniq)
  end

  def not_friends
    # Collecter les IDs de tous les utilisateurs impliqués dans une relation d'amitié avec `current_user`, peu importe le statut
    all_friendship_ids = Friendship.where(user: self).or(Friendship.where(friend_of: self)).pluck(:user_id, :friend_of_id).flatten.uniq

    # Exclure à la fois les amis et l'utilisateur actuel de la liste des utilisateurs potentiels
    User.where.not(id: all_friendship_ids + [id])
  end


  def pending_friendships
    Friendship.where(friend_of: self, status: "pending")
  end

  def pending_friendships_sent
    Friendship.where(user: self, status: "pending")
  end


end
