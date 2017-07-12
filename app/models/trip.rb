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
  has_many :comments
  belongs_to :user

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
end
