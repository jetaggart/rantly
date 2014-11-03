class FavoritesController < SignInRequiredController
  def index
    @favorite_rants = current_user.favorite_rants
  end

  def create
    rant = Rant.find(params[:rant_id])
    rant.favorites.create!(:user => current_user)
    
    render :partial => "favorite", :locals => {:rant => rant}
  end

  def destroy
    rant = Rant.find(params[:rant_id])
    Favorite.find(params[:id]).destroy!

    render :partial => "favorite", :locals => {:rant => rant}
  end
end
