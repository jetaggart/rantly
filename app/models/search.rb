class Search
  attr_accessor :query

  def initialize(query)
    @query = query
  end

  def results
    return [] if query.blank?

    Rant.joins(:author).where(where_statement, *bind_variables)
  end

  private

  def terms_to_search
    ["users.first_name", "users.last_name", "users.username",
     "rants.body", "rants.title"]
  end

  def bind_variable
    "%#{query}%"
  end

  def bind_variables
    terms_to_search.length.times.map { bind_variable }
  end

  def where_statement
    terms_to_search.map { |t| "#{t} like ?" }.join(" OR ")
  end

end
