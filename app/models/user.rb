class User < ApplicationRecord
  has_many :friends
  has_many :comments
  has_many :events
  has_many :trips, through: :events
  has_many :locations, through: :events
  has_many :images, through: :events
end
