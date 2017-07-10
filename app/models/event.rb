class Event < ApplicationRecord
  #belongs_to :trip
  belongs_to :user
  #belongs_to :location
  belongs_to :type
  has_many :comments
  has_many :images

  validates :review, presence: true,
                     length: {minimum: 30}
  validates :rating, presence: true

  def type=(type_name)
    Type.find_or_create_by(name: type_name).events << self
  end


end
