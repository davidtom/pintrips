class Event < ApplicationRecord
  #belongs_to :trip
  belongs_to :user
  #belongs_to :location
  belongs_to :type
  has_many :comments
  has_many :images
  belongs_to :trip, optional: true

  validates :review, presence: true,
                     length: {minimum: 30}
  validates :rating, presence: true

  def type_name= (type_name)
    Type.find_or_create_by(name: type_name).events << self
  end

  def type_name
    self.type.name if type
  end


end
