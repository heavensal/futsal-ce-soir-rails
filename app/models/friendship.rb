class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend_of, class_name: "User"

  validates :user_id, uniqueness: { scope: :friend_of_id }
  validates :status, presence: true, inclusion: { in: %w[pending accepted declined blocked] }
  validate :not_self

  def not_self
    errors.add(:friend_of_id, "can't be equal to user_id") if user_id == friend_of_id
  end


end
