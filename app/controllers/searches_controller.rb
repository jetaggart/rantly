class SearchesController < SignInRequiredController

  def show
    @search = Search.new(params[:query])
  end

end
