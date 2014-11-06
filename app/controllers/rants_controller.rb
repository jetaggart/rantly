class RantsController < SignInRequiredController
  def show
    @rant = Rant.find(params[:id])
  end
  
  def create
    rant = Rant.new(
      allowed_params.merge(:author => current_user)
    )

    if rant.save
      render :nothing => true
    else
      render :partial => "rants/form", :status => 422, :locals => {:rant => rant}
    end

  end

  def destroy
    Rant.find(params[:id]).destroy!
    redirect_to dashboard_path, :notice => "Rant deleted"
  end

  def spam
    Rant.find(params[:id]).toggle!(:spam)

    redirect_to dashboard_path, :notice => "Rant has been marked as spam"
  end

  private

  def allowed_params
    params.require(:rant).permit(:title, :body)
  end
end
