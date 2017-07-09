class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates_uniqueness_of :user_id, scope: :friend_id

  def self.between (user1, user2)
    user1.friendships.find_by(friend_id: user2)
  end

end
