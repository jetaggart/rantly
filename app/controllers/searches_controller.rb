class SearchesController < SignInRequiredController

  def show
    @search = Search.new(params[:search] || {:query => nil})
  end

end
