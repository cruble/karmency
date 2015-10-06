# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

chad = User.create(first_name: "Chad", last_name: "Ruble", email: "chad@example.com", password: "flatiron")
parker = User.create(first_name: "Parker", last_name: "Lawrence", email: "parker@example.com", password: "flatiron")
amanda = User.create(first_name: "Amanda", last_name: "Chang", email: "amanda@example.com", password: "flatiron")

coin1 = Coin.create(code: "0001", creator: chad)
coin2 = Coin.create(code: "0002", creator: parker)
coin3 = Coin.create(code: "0003", creator: parker)
coin4 = Coin.create(code: "0004", creator: parker)
coin5 = Coin.create(code: "0005", creator: parker)


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

def next_number(last_number)
  if last_number.to_i < 9
    "0" + (last_number.to_i + 1).to_s
  else 
    (last_number.to_i + 1).to_s
  end 
end 

reserved_initials = ["AR", "JG", "PL", "LR", "XX", "KC", "CR"]
reserved_initials.each do | initials|
  first_code = initials + "00"
  ReservedCode.create(code: first_code)
  numbers = ["0"]
  99.times {
    last_number = next_number(numbers[-1])
    numbers << last_number
    ReservedCode.create(code: (initials + last_number))
  }
end 

# Coin.all.each do |coin|
#   CoinAlert.create(coin_id: coin.id, user_id: coin.creator.id, status:true)
# end 
i = 5
10.times {
  CoinAlert.create(coin_id: i, user_id: 6, status: true)
  i += 1 
}



