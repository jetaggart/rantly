module Admin
  class DashboardsController < AdminRequiredController
    def show
      @rants_per_day_data = RantsPerDay.new.to_json
      @signups_per_day_data = SignupsPerDay.new.to_json
      @logins_per_hour_data = LoginsPerHour.new.to_json
    end
  end
end
