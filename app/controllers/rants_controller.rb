class RantsController < SignInRequiredController
  def show
    @rant = Rant.find(params[:id])
  end
  
  def create
    rant = Rant.new(
      allowed_params.merge(:author => current_user)
    )

    rant.save!

    redirect_to dashboard_path, :notice => "Rant created"
  end

  def destroy
    Rant.find(params[:id]).destroy!
    redirect_to dashboard_path, :notice => "Rant deleted"
  end

  private

  def allowed_params
    params.require(:rant).permit(:title, :body)
  end
end
