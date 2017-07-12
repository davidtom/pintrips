# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string
#  password_digest :string
#  first_name      :string
#  last_name       :string
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :comments
  has_many :events
  has_many :trips
  has_many :locations, through: :events
  has_many :images, through: :events

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :user_name, presence: true,
                        uniqueness: {case_sensitive: false},
                        length: {minimum:3, maximum: 25}

  has_secure_password

  def is?(object)
    # Used primarily to see if the user is the current_user on view pages
    self == object
  end

  def orphan_events
    self.events.select {|event| event.is_orphan?}
  end

  def friend_trips
    self.friends.collect {|friend| friend.trips}.flatten
  end

end
