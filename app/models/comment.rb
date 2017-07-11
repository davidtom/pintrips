class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :trip, optional: true
  belongs_to :event, optional: true
  validate :event_or_user


  def event_or_user
    if !self.trip && !self.event
      #Add error to comment.
      byebug
      errors[:base] << "Comment must be associated with either a trip or an event"
    end
  end

end
