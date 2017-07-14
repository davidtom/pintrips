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
  has_many :images

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :user_name, presence: true,
                        uniqueness: {case_sensitive: false},
                        length: {minimum:3, maximum: 25}

  has_secure_password

  # TODO DELETE once all uses have been removed in views
  # def is?(object)
  #   # Used primarily to see if the user is the current_user on view pages
  #   self == object
  # end

  def completed_trips
    self.trips.where(on_wish_list: false)
  end

  def orphan_events
    #old code for reference
    # self.events.select {|event| event.is_orphan? && event.on_wish_list == false}
    self.events.where(on_wish_list: false, trip_id: nil)
  end

  def wish_list_trips
    self.trips.where(on_wish_list: true)
  end

  def wish_list_events
    self.events.where(on_wish_list: true)
  end

  def friend_trips
    #get ids of friends
    friend_ids = self.friends.pluck(:id)
    #find trips that have user_id that matches a friend_id
    Trip.where(user_id: friend_ids)
    #old code for reference
    # self.friends.collect {|friend| friend.trips}.flatten
  end

end
