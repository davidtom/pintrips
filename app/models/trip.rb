class Trip < ApplicationRecord
  has_many :events
  has_many :comments
  belongs_to :user

  def event_titles
    self.events.map { |e| e.title }
  end

  def event_titles=(titles)
    events_arr = titles.map do |title|
      Event.find_by(title: title)
    end

    events_arr.each do |event|
      self.events << event
    end
  end
end
