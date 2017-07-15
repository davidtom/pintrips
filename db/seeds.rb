# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
#
# #

@users_with_trips = User.select { |u| !u.trips.empty? }
@users_with_events = User.select { |u| !u.events.empty? }


def random_event
  Event.all[rand(0...Event.all.count)]
end

def random_trip
  Trip.all[rand(0...Trip.all.count)]
end

def random_user
  User.all[rand(0...User.all.count)]
end

def random_user_with_trips  #Returns a random user that has at least one trip
  @users_with_trips[rand(0...@users_with_trips.count)] # three dots means it doesn't include the highest number
end

def random_user_with_events
  @users_with_events[rand(0...@users_with_events.count)]
end

def random_user_with_trips_or_events
  pool = @users_with_events + @users_with_trips
  pool[rand(0...pool.count)]
end

def random_user_trip(user)
  return nil if user.trips.empty?
  user.trips[rand(0...user.trips.count)]
end

def random_user_event(user)
  return nil if user.events.empty?
  user.events[rand(0...user.events.count)]
end

def random_type
  Type.find(rand(1..Type.all.count))
end

def random_location
  Location.all[rand(0...Location.all.count)]
end



puts "Seeding..."

Type.create(name:"Nightlife")
Type.create(name:"Restaurants")
Type.create(name:"Outdoors/Nature")
Type.create(name:"Lodging")
Type.create(name:"misc")

pup_1 = User.create(user_name: "pup_1", first_name: "Torben", last_name: "Wooley", email: "torben@torben.com", password: "admin")
charles = User.create(user_name: "charles", first_name: "Charles", last_name: "Wooley", email: "charles@charles.com", password: "admin")
jeremy646 = User.create(user_name: "jeremy646", first_name: "Jeremy", last_name: "Lenz", email: "jeremylenz@gmail.com", password: "admin")
david = User.create(user_name: "david_not_dave", first_name: "David", last_name: "Tomczyk", email: "david@david.david", password: "admin")
jeff = User.create(user_name: "jeffkatzy", first_name: "Jeffrey", last_name: "Katz", email: "hangman_is_king@gmail.com", password: "admin")

bk = Trip.create(name: "Bangkok", start_date: "07/07/2017", end_date: "07/09/2017", user: User.find_by(user_name: "david_not_dave"))

im1 = Image.create(title: 'Bangkok_1', url: 'http://static.asiawebdirect.com/m/bangkok/portals/bangkok-com/shared/teasersL/TOP10/top-10-short-things-to-do-in-bangkok/teaserMultiLarge/imageHilight/teaser.jpeg.jpg', user_id: 3)


im1.featured = true
im1.trip = bk
im1.save

Location.create(name: "Bangkok")
les = Location.create(name: "Lower East Side")
nyc = Location.create(name: "New York City")

ev1 = Event.create(title: "NYHRC Boat Cruise", review: "Went on NYHRC Boat cruise.  It was great!  They had good broccoli.  We saw the Statue of Liberty!  Also there were cookies but I didn't get any :(", rating: 9, date: "07/09/2017", user: User.find_by(user_name: "jeremy646"), type: Type.find_by(name: "Outdoors/nature"), location: nyc)
ev2 = Event.create(title: "Gggrrgghhgh", review: "something adorable about chewing on bones", rating: 10, date: "07/08/2017", user: User.find_by(user_name: "pup_1"), type: Type.find_by(name: "Restaurants"), location: les)

puts "Created manual seeds"



# # -----------  FAKER SEEDS BELOW --------------------


100.times do |i|
  User.create(user_name: Faker::Internet.user_name, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "admin")
  print "Created #{i+1} users\r"
end
puts ""

200.times do |i|
  start_date = Faker::Date.between("1/1/2000".to_date, "7/1/2017".to_date)
  end_date = start_date + rand(3..10)
  Trip.create(name: Faker::Address.city, start_date: start_date, end_date: end_date, user: random_user)
  print "Created #{i+1} trips\r"
end
puts ""

20.times do |i|
  Location.create(name: Faker::Simpsons.location)
  print "Created #{i+1} Simpsons Locations\r"
end
puts ""

cities = ["Bangkok", "Shanghai", "Beijing", "Delhi", "Lagos", "Dhaka", "Tokyo", "Cairo", "New York", "Los Angeles", "Chicago", "New Orleans", "San Francisco", "Kearney, NE", "Guam", "London", "Dublin", "Paris", "Frankfurt", "Berlin", "Hong Kong", "Rio de Janeiro", "Santiago", "Dubai", "Toronto", "Yellowknife", "Las Vegas", "Boise, ID", "Detroit"]

cities.each_with_index do |city, i|
  Location.create(name: city)
  print "Created #{i+1} real city locations\r"
end
puts ""



150.times do |i|
  event_name = "#{Faker::Pokemon.name}'s #{Faker::Food.ingredient.pluralize}"
  event_review = Faker::Hipster.sentences(4).join(" ")
  event_date = Faker::Date.between("1/1/1997".to_date, "7/1/2018".to_date)

  Event.create(title: event_name, review: event_review, rating: rand(1..10), date: event_date, user: random_user, type: random_type, location: random_location)
  print "Created #{i+1} events\r"
end
puts ""

150.times do |i|
  event_name = "#{Faker::Pokemon.name}'s #{Faker::Dessert.variety.pluralize}"
  event_review = Faker::Hipster.sentences(4).join(" ")
  event_date = Faker::Date.between("1/1/2000".to_date, "7/1/2018".to_date)

  ev = Event.create(title: event_name, review: event_review, rating: rand(1..10), date: event_date, user: random_user, type: random_type, location: random_location)
  byebug if ev.errors.any?
  print "Created #{i+1} more events\r"
end
puts ""

# Events are not created with a trip.  Assign them to random trips.
puts "Assigning events to trips..."
Event.all.each do |event|
  event.trip = random_user_trip(event.user)
  event.save
  byebug if event.errors.any?
end
puts "Assigned all events to trips"

@users_with_trips = User.select { |u| !u.trips.empty? }
@users_with_events = User.select { |u| !u.events.empty? }

puts "Seeding images..."

image_urls = {
  bangkok: "http://lghttp.60358.nexcesscdn.net/8046264/images/page/-/100rc/img/cities/cities-bangkok_optimized.jpg",
  shanghai: "https://www.omm.com/~/media/images/site/locations/shanghai_780x520.ashx",
  beijing: "http://img.timeoutbeijing.com/201702/20170214122812289.jpg",
  delhi: "https://www.fssaifoodlicense.com/wp-content/uploads/2016/05/delhi2-1.jpg",
  lagos: "http://tortoisepath.com/blog/wp-content/uploads/sites/5/2016/05/lagos-city-nigeria-image.jpg",
  dhaka: "http://www.theindependentbd.com/assets/news_images/Decentralising-Dhaka.jpg",
  tokyo: "http://static.asiawebdirect.com/m/phuket/portals/japan-hotels-ws/homepage/tokyo/nightlife/pagePropertiesImage/tokyo-nightlife.jpg",
  cairo: "http://images.kuoni.co.uk/73/mena-house-38484241-1477473283-ImageGalleryLightboxLarge.jpg",
  new_york: "https://www.gentlegiant.com/wp-content/uploads/2015/06/New-York.jpg",
  los_angeles: "http://usa.sae.edu/assets/Campuses/Los-Angeles/2015/Los_Angeles_city_view.jpg",
  chicago: "http://cdn-image.travelandleisure.com/sites/default/files/styles/1600x1000/public/1446655168/chicago-header-dg1115.jpg?itok=MqZFOaTi",
  new_orleans: "https://premiumparking-api.s3.amazonaws.com/market/NEW%20ORLEANS%2C%20LA.jpg",
  san_francisco: "http://www.sftravel.com/sites/sftraveldev.prod.acquia-sites.com/files/SanFrancisco_0.jpg",
  kearney: "https://media-cdn.tripadvisor.com/media/photo-s/01/04/30/d9/the-grand-archway-at.jpg",
  guam: "https://media-cdn.tripadvisor.com/media/photo-s/01/28/d3/32/guam.jpg",
  london: "https://media.timeout.com/images/103042848/image.jpg",
  dublin: "http://monipag.com/kevin-paquier/wp-content/uploads/sites/3558/2017/03/dublin_full_destination.jpg",
  paris: "http://www.telegraph.co.uk/content/dam/Travel/Destinations/Europe/France/Paris/paris-attractions-xlarge.jpg",
  frankfurt: "https://www.hotel-scala-frankfurt.de/files/Fotolia_60916895_XXL_1.jpg",
  berlin: "http://www.telegraph.co.uk/content/dam/Travel/Destinations/Europe/Germany/Berlin/Berlin-overview-cityscape-xlarge.jpg",
  hong_kong: "http://magic.wizards.com/sites/mtg/files/images/featured/GP_HongKong.jpg",
  rio_de_janiero: "http://www.getsready.com/wp-content/uploads/2016/08/Rio-de-Janeiro-an-amazing-part-in-brazil.jpg",
  santiago: "https://static.independent.co.uk/s3fs-public/thumbnails/image/2016/12/20/17/santiago031-.jpg",
  dubai: "http://images.kuoni.co.uk/73/dubai-37075265-1494255242-ImageGalleryLightboxLarge.jpg",
  toronto: "http://images.kuoni.co.uk/73/dubai-37075265-1494255242-ImageGalleryLightboxLarge.jpg",
  yellowknife: "http://www.nwthumanrights.ca/cashra2007/graphics/yk.jpg",
  las_vegas: "https://vegasgirlsnightout.com/wp-content/uploads/2016/01/vegas-burj-al-arab.jpg",
  boise: "http://inception-app-prod.s3.amazonaws.com/MzU5NTI2MDgtY2RkYi00OWZiLTg2ZGYtZDk5MTVhZGI0YmQ3/content/2017/05/Boise%20ID-2.jpg",
  detroit: "https://s3.amazonaws.com/handup-static/img/detroit/detroit-social.jpg"

}
10.times do
  image_urls.each do |name, url|
    img = Image.create(title: name, url: url, caption: "my awesome picture of #{name.to_s.capitalize}", user: random_user_with_trips_or_events)
    print "Created image for #{name}\r            "
    $stdout.flush
  end
end
puts ""
puts "Created #{image_urls.keys.count * 10} images"

print "Assigning images..."

Image.all.each do |img|
  if !img.user.trips.empty?
    img.trip = random_user_trip(img.user)
    img.featured = true if img.trip.images.empty?
    img.save
  elsif !img.user.events.empty?
    img.event = random_user_event(img.user)
    img.featured = true if img.event.images.empty?
    img.save
  end
  byebug if img.errors.any?
end

puts "done"




150.times do |i|
  user1 = random_user_with_events
  Comment.create(content: Faker::Simpsons.quote, user: random_user, event: random_user_event(user1))
  print "Created #{i+1} Simpsons Event comments\r"
end
puts ""

150.times do |i|
  user1 = random_user_with_trips
  Comment.create(content: Faker::Simpsons.quote, user: random_user, trip: random_user_trip(user1))
  print "Created #{i+1} Simpsons Trip comments\r"
end
puts ""

150.times do |i|
  user1 = random_user_with_events
  Comment.create(content: Faker::FamilyGuy.quote, user: random_user, event: random_user_event(user1))
  print "Created #{i+1} FamilyGuy comments\r"
end
puts ""

150.times do |i|
  user1 = random_user_with_events
  Comment.create(content: Faker::Yoda.quote, user: random_user, event: random_user_event(user1))
  print "Created #{i+1} Yoda comments\r"
end
puts ""

20.times do |i|
  user1 = random_user_with_trips
  Comment.create(content: Faker::RuPaul.quote, user: random_user, trip: random_user_trip(user1))
  print "Created #{i+1} RuPaul comments\r"
end
puts ""
