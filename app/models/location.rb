# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  name        :string
#  coordinates :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Location < ApplicationRecord
  include HTTParty
  has_many :events
  before_save :set_coords
  validates :name, presence: true
  @@APIKEY = 'AIzaSyBsxlU4Q04vn0Qnf2gTGhFBFsBxo04xZ-w'


  def set_coords
    #Call Google Maps API to set lattitude and longitude
    #location hash will be at
    # response['results'][0]['geometry']['location']
    url_name = name.split(' ').join('+')
    request_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{url_name}&key=#{@@APIKEY}"
    # request_url = "https://maps.googleapis.com/maps/api/geocode/json?address="
    response = HTTParty.get(request_url)
    if !response['results'].empty?
      self.lat = response['results'][0]['geometry']['location']['lat']
      self.long = response['results'][0]['geometry']['location']['lng']
    else
      self.lat = '40.705185'
      self.long = '-74.013932'
    end

  end
end
