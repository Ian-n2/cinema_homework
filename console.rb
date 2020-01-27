require('pry')
require_relative("models/tickets.rb")
require_relative("models/films.rb")
require_relative("models/customer.rb")
require_relative("models/screenings.rb")

Ticket.delete_all
Film.delete_all
Customer.delete_all
Screening.delete_all

customer1 = Customer.new({
  "name" => "Ian",
  "funds" => "40"
  })

customer2 = Customer.new({
  "name" => "Steven",
  "funds" => "40"
  })

customer3 = Customer.new({
  "name" => "Peter",
  "funds" => "40"
  })

  customer1.save()
  customer2.save()
  customer3.save()

film1 = Film.new({
  "title" => "Fight man",
  "price" => "10"

  })

film2 = Film.new ({
  "title" => "Romcom",
  "price" => "10"

  })

  film1.save()
  film2.save()


  screening1 = Screening.new({
    "film_id" => film1.id,
    "show_time" => 9,
    "remaining_tickets" => 5
    })

    screening2 = Screening.new({
      "film_id" => film2.id,
      "show_time" => 7,
      "remaining_tickets" => 5
      })
      
  screening1.save()
  screening2.save()

ticket1 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film1.id,
  "screening_id" => screening1.id
  })

ticket2 = Ticket.new({
"customer_id" => customer2.id,
"film_id" => film1.id,
"screening_id" => screening1.id
})

ticket3 = Ticket.new({
"customer_id" => customer3.id,
"film_id" => film2.id,
"screening_id" => screening2.id
})

ticket1.save()
ticket2.save()
ticket3.save()

binding.pry
nil
