module Admin
  class RantsController < AdminRequiredController
    def index
      @rants = Rant.all

      if params[:start_date].present?
        @rants = @rants.where("created_at >= ?", params[:start_date])
      end

      if params[:end_date].present?
        @rants = @rants.where("created_at <= ?", params[:end_date])
      end
    end
  end
end
