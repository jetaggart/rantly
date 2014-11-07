module Admin
  class RantsController < AdminRequiredController

    def index
      @rants = Rant
                 .unscoped
                 .where(spam_clause)
                 .where(start_date_clause)
                 .where(end_date_clause)
    end

    def spam
      Rant.unscoped.find(params[:id]).toggle!(:spam)
      redirect_to(admin_rants_path(:spam => true),
                  :notice => "Spam is resolved")
    end

    def destroy
      Rant.unscoped.find(params[:id]).destroy!
      redirect_to(admin_rants_path(:spam => true),
                  :notice => "Rant deleted")
    end


    private

    def end_date_clause
      if params[:end_date].present?
        ["created_at <= ?", params[:end_date]]
      else
        []
      end
    end

    def start_date_clause
      if params[:start_date].present?
        ["created_at >= ?", params[:start_date]]
      else
        []
      end
    end

    def spam_clause
      @viewing_spam = params[:spam] == "true"

      {:spam => @viewing_spam}
    end
    
  end
end
