# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#
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

Location.create(name: "Bangkok", coordinates: "Thailand")
Location.create(name: "Lower East Side", coordinates: "East Broadway")

ev1 = Event.create(title: "NYHRC Boat Cruise", review: "Went on NYHRC Boat cruise.  It was great!  They had good broccoli.  We saw the Statue of Liberty!  Also there were cookies but I didn't get any :(", rating: 9, date: "07/09/2017", user: User.find_by(user_name: "jeremy646"), type: Type.find_by(name: "Outdoors/nature"))
ev2 = Event.create(title: "Gggrrgghhgh", review: "something adorable about chewing on bones", rating: 10, date: "07/08/2017", user: User.find_by(user_name: "pup_1"), type: Type.find_by(name: "Restaurants"))
byebug if ev1.errors.any?
byebug if ev2.errors.any?
byebug if bk.errors.any?


comm = Comment.new
comm.content = "THIS PLACE SUXXXX"
comm.user = pup_1
comm.event = ev2

byebug if Event.count == 0
byebug if Trip.count == 0
