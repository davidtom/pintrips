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


end
