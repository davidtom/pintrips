# == Schema Information
#
# Table name: trips
#
#  id         :integer          not null, primary key
#  name       :string
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Trip < ApplicationRecord
  has_many :events
  has_many :comments, :dependent => :destroy
  belongs_to :user
  has_many :images, :dependent => :destroy

  before_save :check_featured_image
  before_destroy :clear_events

  def check_featured_image # Check the trip to see if a featured image has been added.  If so, add the image to trip.images
    if self.featured_image
      if !self.images.include?(self.featured_image)  #Only add it if it's not already there
        self.images << self.featured_image
      end
    end
  end

  def self.all_with_events
    # Store trip_ids from all Events that have one (!= nil)
    trip_ids = Event.where.not(trip_id: nil).pluck(:trip_id)
    # Find all of those trips from Trips table
    Trip.where(id: trip_ids)
  end

  def event_titles
    self.events.map { |e| e.title }
  end

  def event_ids=(ids)
    events_arr = ids.map do |id|
      Event.find(id)
    end

    events_arr.each do |event|
      self.events << event
    end
  end

  def featured_image
    self.images.find do |image|
      image.featured == true
    end
  end

  def featured_image_url
    if featured_image
      return featured_image.url
    else
      return ""
    end
  end




  private

  def clear_events
    self.events.each do |event|
      event.destroy
    end
  end
end
