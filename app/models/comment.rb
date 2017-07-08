class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :trip
  belongs_to :event
end
