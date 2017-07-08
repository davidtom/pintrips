class User < ApplicationRecord
  has_many :friends
  has_many :comments
  has_many :events
  has_many :trips, through: :events
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
end
