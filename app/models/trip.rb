class Trip < ApplicationRecord
  has_many :events
  has_many :comments
  belongs_to :user
end
