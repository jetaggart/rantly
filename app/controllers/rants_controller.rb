class RantsController < ApplicationController
  def create
    rant = Rant.new(
      allowed_params.merge(:author => current_user)
    )

    rant.save!

    redirect_to dashboard_path, :notice => "Rant created"
  end

  private

  def allowed_params
    params.require(:rant).permit(:title, :body)
  end
end