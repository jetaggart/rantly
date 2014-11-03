class Search
  include ActiveModel::Model

  attr_accessor :query

  def results
    return [] if query.blank?

    Rant.joins(:author).where(where_statement, *bind_variables)
  end

  private

  def terms_to_search
    ["first_name", "last_name"]
  end

  def bind_variable
    "%#{query}%"
  end

  def bind_variables
    terms_to_search.length.times.map { bind_variable }
  end

  def where_statement
    terms_to_search.map { |t| "users.#{t} like ?" }.join(" OR ")
  end

end
