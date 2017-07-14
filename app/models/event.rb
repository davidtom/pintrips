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
  belongs_to :location
  belongs_to :type
  has_many :comments, :dependent => :destroy
  has_many :images, :dependent => :destroy
  belongs_to :trip, optional: true
  #if not on wish list, needs 10 chars in review and a rating
  validate :wish_list_or_not
  # validate :valid_location
  validates :location_id, presence: true

  before_save :check_featured_image

  def check_featured_image
    # Check the trip to see if a featured image has been added.  If so, add the image to trip.images
    if self.featured_image
      if !self.images.include?(self.featured_image)  #Only add it if it's not already there
        self.images << self.featured_image
      end
    end
  end

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

  # TODO: refactor code in events_controller.rb to use this; make sure it can be used for copying trips!!
  def copy
    Event.new(
    title: self.title,
    location: self.location,
    type: self.type,
    on_wish_list: true)
  end

  # def clear_for_copy
  #   self.tap do |s|
  #     s.review.clear
  #     s.rating = nil
  #     s.date = nil
  #     s.trip_id = nil
  #
  #   end
  # end

  def featured_image
    self.images.find_by(featured: true)
  end

  def featured_image_url
    if featured_image
      return featured_image.url
    else
      return ""
    end
  end

  private

    def wish_list_or_not
      if !on_wish_list
        errors[:rating] << "must exist" if rating.nil?
        if review
          errors[:review] << "must be more than 10 characters" if review.length <= 10
        end
      end
    end

end
