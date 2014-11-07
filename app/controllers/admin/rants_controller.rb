module Admin
  class RantsController < AdminRequiredController
    def index
      @rants = Rant.all
    end
  end
end
