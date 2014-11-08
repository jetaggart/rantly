class RantsPerDay
  def as_json(options = {})
    return {:labels => [], :datasets => []} if Rant.count == 0

    grouped_rants = Rant.all.group_by do |rant|
      rant.created_at.to_date
    end

    days = grouped_rants.keys

    max_day = days.max
    min_day = days.min
    date_range = (min_day..max_day)

    {
      :labels => date_range.map { |d| d.iso8601 },
      :datasets => [
        :label => "Rants per Day",
        :fillColor => "rgba(220,220,220,0.5)",
        :strokeColor => "rgba(220,220,220,0.8)",
        :highlightFill => "rgba(220,220,220,0.75)",
        :highlightStroke => "rgba(220,220,220,1)",
        :data => date_range.map { |d| grouped_rants.fetch(d, []).length }
      ]
    }
  end

end
