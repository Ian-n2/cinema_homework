require_relative("../DB/Sql_runner.rb")

class Screening

  attr_reader :id
  attr_accessor :film_id, :show_time, :remaining_tickets 

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @film_id = options["film_id"].to_i
    @show_time = options["show_time"].to_i
    @remaining_tickets = options["remaining_tickets"].to_i
  end


  def save()
    sql = "INSERT INTO screenings (film_id, show_time, remaining_tickets)
    VALUES ($1, $2, $3)
    RETURNING id"
    values = [@film_id, @show_time, @remaining_tickets]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.delete_all
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * from screenings"
    result = SqlRunner.run(sql)
    return result.map{|screening| Screening.new(screening)}
  end


  def check_tickets
    return @remaining_tickets
  end

  def find_popular_time
    sql = "SELECT screenings.show_time
    FROM screenings INNER JOIN tickets
    ON tickets.screening_id = screenings.id
    WHERE tickets.film_id = $1
    GROUP BY screenings.show_time
    ORDER BY COUNT(*) DESC"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result[0]["start_time"]
  end






end
