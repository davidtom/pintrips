class Trip < ApplicationRecord
  has_many :events
  has_many :comments
  belongs_to :user
  has_many :images
  belongs_to :featured_image, class_name: "Image"  #Has_one would make more sense gramatically, but I had to use belongs_to here because I want the foreign key to be on the Trip table, not the Image table.

  before_save :check_featured_image

  def check_featured_image # Check the trip to see if a featured image has been added.  If so, add the image to trip.images
    if self.featured_image
      if !self.images.include?(self.featured_image)  #Only add it if it's not already there
        self.images << self.featured_image
      end
    end
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
