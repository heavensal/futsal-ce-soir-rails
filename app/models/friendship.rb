class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend_of, class_name: "User"

  validates :user_id, uniqueness: { scope: :friend_of_id }
  validates :status, presence: true, inclusion: { in: %w(pending accepted declined blocked) }
  validate :not_self



end
