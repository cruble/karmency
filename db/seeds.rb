# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

chad = User.create(email: "chad@example.com", password: "flatiron")
parker = User.create(email: "parker@example.com", password: "flatiron")
amanda = User.create(email: "amanda@example.com", password: "flatiron")

coin1 = Coin.create(code: "0001", creator: chad)
coin2 = Coin.create(code: "0002", creator: parker)


moment1 = Moment.create(coin_id: 1, description: "He gave his seat", location: "Brooklyn, NY")
moment1.giver = chad
moment1.receiver = parker 

moment2 = Moment.create(coin_id: 1, description: "He made a smoothie", location: "Manhattan, NY")
moment2.giver = parker
moment2.receiver = amanda 

moment3 = Moment.create(coin_id: 2, description: "She helped me code", location: "Brooklyn, NY")
moment3.giver = parker
moment3.receiver = amanda

moment4 = Moment.create(coin_id: 2, description: "He gave me ice cream", location: "Flatiron, NY")
moment4.giver = amanda
moment4.receiver = chad 

[moment1, moment2, moment3, moment4].each {|moment| moment.save}
