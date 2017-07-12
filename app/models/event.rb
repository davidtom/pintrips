# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  review      :text
#  rating      :integer
#  date        :datetime
#  trip_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  location_id :integer
#  type_id     :integer
#  title       :string
#

class Event < ApplicationRecord
  #belongs_to :trip
  belongs_to :user
  belongs_to :location, optional: true
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

  def location_name
    # Location.find(self.location_id).name if self.location_id
    self.location.name if self.location
  end

  def location_name=(name)
    self.location = Location.find_or_create_by(name: name)
  end

  def is_orphan?
    self.trip_id == nil
  end

end
