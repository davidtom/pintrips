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

  before_destroy :clear_events




  def self.all_with_events
    # Store trip_ids from all Events that have one (!= nil)
    trip_ids = Event.where.not(trip_id: nil).pluck(:trip_id)
    # Find all of those trips from Trips table
    Trip.where(id: trip_ids)
  end

  def event_titles
    self.events.pluck(:title)
  end

  def event_ids=(ids)
    self.events << Event.where(id: ids)
    #events that are added to a trip (new or update), are set to that trips' on_wish_list status
    self.events.update(on_wish_list: self.on_wish_list)
    # self.events.each do |event|
    #   event.on_wish_list = self.on_wish_list
    # end
    #Old code for reference:
    # events_arr = ids.map do |id|
    #   Event.find(id)
    # end
    #
    # events_arr.each do |event|
    #   self.events << event
    # end
  end

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

  def copy
    Trip.new(
    name: self.name,
    start_date: nil,
    end_date: nil,
    on_wish_list: true
    )
  end

  def copy_events(current_user, new_trip)
    self.events.each {|e| e.copy.update(user_id: current_user.id, trip_id: new_trip.id)}
  end

  private

    def clear_events
      self.events.each do |event|
        event.destroy
      end
    end

end
