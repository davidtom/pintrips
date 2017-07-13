# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
#
# #
Type.create(name:"Nightlife")
Type.create(name:"Restaurants")
Type.create(name:"Outdoors/nature")
Type.create(name:"Lodging")

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




# # -----------  FAKER SEEDS BELOW --------------------

100.times do
  User.create(user_name: Faker::Internet.user_name, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "admin")
end
puts "Created 100 users"

50.times do
  start_date = Faker::Date.between("1/1/2000".to_date, "7/1/2017".to_date)
  end_date = start_date + rand(3..10)
  Trip.create(name: Faker::Address.city, start_date: start_date, end_date: end_date, user: User.find(rand(1..99)))
end
puts "Created 50 trips"

20.times do
  Location.create(name: Faker::Simpsons.location)
end
puts "Created 20 Locations"

40.times do
  Location.create(name: Faker::Address.city)
end
puts "Created 40 locations"

9.times do
  Location.create(name: Faker::Address.community)
end
puts "Created 9 locations"

60.times do
  event_name = "#{Faker::Pokemon.name}'s #{Faker::Food.ingredient.pluralize}"
  event_review = Faker::Hipster.sentences(4).join(" ")
  event_date = Faker::Date.between("1/1/2000".to_date, "7/1/2018".to_date)

  Event.create(title: event_name, review: event_review, rating: rand(1..10), date: event_date, user: User.find(rand(1..99)), type: Type.find(rand(1..Type.all.count)), location: Location.find(rand(1..Location.all.count)))
end
puts "Created 60 events"

60.times do
  event_name = "#{Faker::Pokemon.name}'s #{Faker::Dessert.variety.pluralize}"
  event_review = Faker::Hipster.sentences(4).join(" ")
  event_date = Faker::Date.between("1/1/2000".to_date, "7/1/2018".to_date)

  ev = Event.create(title: event_name, review: event_review, rating: rand(1..10), date: event_date, user: User.find(rand(1..99)), type: Type.find(rand(1..Type.all.count)), location: Location.find(rand(1..Location.all.count)))
  byebug if ev.errors.any?
end
puts "Created 60 events"

# Events are not created with a trip.  Assign them to random trips.
Event.all.each do |event|
  num = rand(1..50)
  event.trip = Trip.find(num)
  Trip.find(num).events << event
end

#
# Trip.all.each do |trip|
#   us = trip.user
#   us.trips << trip
# end


150.times do
  Comment.create(content: Faker::Simpsons.quote, user: User.find(rand(1..99)), event: Event.find(rand(1..40)))
end
puts "Created 150 Simpsons Event comments"

150.times do
  Comment.create(content: Faker::Simpsons.quote, user: User.find(rand(1..99)), trip: Trip.find(rand(1..50)))
end
puts "Created 150 Simpsons Trip comments"

150.times do
  Comment.create(content: Faker::FamilyGuy.quote, user: User.find(rand(1..99)), event: Event.find(rand(1..40)))
end
puts "Created 150 FamilyGuy comments"

150.times do
  Comment.create(content: Faker::Yoda.quote, user: User.find(rand(1..99)), event: Event.find(rand(1..40)))
end
puts "Created 150 Yoda comments"

20.times do
  Comment.create(content: Faker::RuPaul.quote, user: User.find(rand(1..99)), trip: Trip.find(rand(1..50)))
end
puts "Created 20 RuPaul comments"
