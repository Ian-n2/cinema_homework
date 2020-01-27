require_relative("../DB/Sql_runner.rb")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options["id"].to_i if options["id"]
@title = options["title"]
@price = options["price"].to_i
end

def save()
    sql = "INSERT INTO films
     (title, price)
    VALUES ($1, $2)
    RETURNING id"
    values = [@title, @price]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.delete_all
      sql = "DELETE FROM films"
      SqlRunner.run(sql)
    end

    def self.all
    sql = "SELECT * from films"
    result = SqlRunner.run(sql)
    return result.map{|film| Film.new(film)}
  end

  def update()
  sql = "UPDATE film SET (title, price) = ($1, $2)
  WHERE id = $3"
  values = [@title, @price, @id]
  SqlRunner.run(sql, values)
end

def customers()
  sql = "SELECT *
  FROM customers INNER JOIN tickets ON
  customers.id = tickets.customer_id
  WHERE tickets.film_id = $1"
  values = [@id]
  result = SqlRunner.run(sql, values)
  return result.map{|customer| Customer.new(customer)} if result.any?
  return nil
end

end
