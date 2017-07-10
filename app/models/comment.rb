class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :trip, optional: true
  belongs_to :event, optional: true
  validate :event_or_user


  def event_or_user
    if !self.trip && !self.event
      #Add error to comment.
      self.errors << "Must have either trip or event"
    end
  end

end
