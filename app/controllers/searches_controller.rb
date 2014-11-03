class Search
  include ActiveModel::Model

  attr_accessor :query

  def results
    return [] if query.blank?

    sql_query = "%#{query}%"
    Rant.joins(:author).where("users.last_name like ?", query)
  end
end

class SearchesController < SignInRequiredController
  def show
    @search = Search.new(params[:search] || {:query => nil})
  end

end
