class Event < ApplicationRecord
  belongs_to :trip
  belongs_to :user
  belongs_to :location
  belongs_to :type
  has_many :comments
  has_many :images
end
