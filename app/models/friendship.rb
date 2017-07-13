# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  friend_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates_uniqueness_of :user_id, scope: :friend_id

  def self.between (user1, user2)
    # user1.friendships.find_by(friend_id: user2)
    !Friendship.from("friendships").where(["user_id = ? AND friend_id = ?", user1.id, user2.id]).empty?
  end

end
