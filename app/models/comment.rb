class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :trip, optional: true
  belongs_to :event, optional: true
  validate :event_or_user


  def event_or_user
    if !self.trip && !self.event
      #Add error to comment.
      errors[:base] << "Comment must be associated with either a trip or an event"
    end
  end

  def trip_or_event

  end

  def trip_or_event=(thing)
  end

end
