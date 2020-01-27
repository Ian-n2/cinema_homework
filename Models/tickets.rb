require_relative("../DB/Sql_runner.rb")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id, :screening_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
@customer_id = options["customer_id"].to_i
@film_id = options["film_id"].to_i
@screening_id = options["screening_id"].to_i

end

def save()
  sql = "INSERT INTO tickets (customer_id, film_id, screening_id)
  VALUES ($1, $2, $3)
  RETURNING id"
  values = [@customer_id, @film_id, @screening_id]
  result = SqlRunner.run(sql, values).first
  @id = result["id"].to_i
end

def self.delete_all
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.all
      sql = "SELECT * from tickets"
      result = SqlRunner.run(sql)
      return result.map{|ticket| Ticket.new(ticket)}
    end





end
