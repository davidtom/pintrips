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
    # Find all events that are associated with a trip (ie have a trip_id)
    Event.where("trip_id IS NOT NULL").ids
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
