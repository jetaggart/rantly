module Admin
  class RantsController < AdminRequiredController
    def index
      @rants = Rant.unscoped

      if params[:start_date].present?
        @rants = @rants.where("created_at >= ?", params[:start_date])
      end

      if params[:end_date].present?
        @rants = @rants.where("created_at <= ?", params[:end_date])
      end

      if params[:spam] == "true"
        @rants = @rants.where(:spam => true)
        @viewing_spam = true
      else
        @rants = @rants.where(:spam => false)
        @viewing_spam = false
      end
    end

    def spam
      Rant.unscoped.find(params[:id]).toggle!(:spam)
      redirect_to admin_rants_path(:spam => true), :notice => "Spam is resolved"
    end

    def destroy
      Rant.unscoped.find(params[:id]).destroy!
      redirect_to admin_rants_path(:spam => true), :notice => "Rant deleted"
    end
  end
end
