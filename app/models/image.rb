# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  url        :string
#  event_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Image < ApplicationRecord
  belongs_to :event, optional: true
  belongs_to :trip, optional: true
  belongs_to :user


  def make_all_other_images_not_featured
    if self.event_id
      current_featured_image = self.event.images.find { |img| img.featured == true }
      current_featured_image.unfeature
    end
    if self.trip_id
      current_featured_image = self.trip.images.find { |img| img.featured == true }
      current_featured_image.unfeature
    end
  end

  def unfeature
      self.featured = false
      self.save
  end


end
