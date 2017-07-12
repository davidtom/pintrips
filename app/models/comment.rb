# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  trip_id    :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
