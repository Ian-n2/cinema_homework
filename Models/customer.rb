require_relative("../DB/Sql_runner.rb")
class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @funds = options["funds"].to_i
  end

  def save()
    sql = "INSERT INTO customers(name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * from customers"
    result = SqlRunner.run(sql)
    return result.map{|customer| Customer.new(customer)}
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2)
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def buy_ticket(film, screening)
    return nil if @funds < film.price
    return nil if screening.remaining_tickets == 0
    @funds -= film.price
    screening.remaining_tickets -= 1
    ticket = Ticket.new("customer_id" => @id, "film_id" => film.id)
    ticket.save()
    update()
  return screening.check_tickets
end

  def films()
    sql = "SELECT *
    FROM films INNER JOIN tickets ON
    films.id = tickets.film_id
    WHERE tickets.customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map{|film| Film.new(film)} if result.any?
    return nil
  end


end
