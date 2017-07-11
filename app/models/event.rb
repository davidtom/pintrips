class Event < ApplicationRecord
  #belongs_to :trip
  belongs_to :user
  belongs_to :location, optional: true
  belongs_to :type
  has_many :comments
  has_many :images

  validates :review, presence: true,
                     length: {minimum: 30}
  validates :rating, presence: true

  def type_name= (type_name)
    Type.find_or_create_by(name: type_name).events << self
  end

  def type_name
    self.type.name if type
  end

  def location_name
    # Location.find(self.location_id).name if self.location_id
    self.location.name
  end

  def location_name=(name)
    self.location = Location.find_or_create_by(name: name)
  end

end
