class Image < ApplicationRecord
  belongs_to :event, optional: true
  belongs_to :trip, optional: true
  belongs_to :user


end
