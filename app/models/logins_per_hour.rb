class LoginsPerHour
  attr_reader :event

  def initialize(event = Event)
    @event = event
  end

  def as_json(options = {})
    {
      :labels => ["12-1 am", "1-2 am", "2-3 am", "3-4 am", "4-5 am",
                  "6-7 am", "7-8 am", "8-9 am", "9-10 am", "10-11 am",
                  "11-12 am", "12-1 pm", "1-2 pm", "2-3 pm", "3-4 pm",
                  "4-5 pm", "5-6 pm", "6-7 pm", "7-8 pm", "8-9 pm",
                  "9-10 pm", "10-11 pm", "11-12 pm"],
      :datasets =>  [
        {
          :fillColor => "rgba(220,220,220,0.5)",
          :strokeColor => "rgba(220,220,220,0.8)",
          :highlightFill => "rgba(220,220,220,0.75)",
          :highlightStroke => "rgba(220,220,220,1)",
          :data => data
        }
      ]
    }
  end

  private

  def hours
    {
      
    }
  end

  def data
    logins_today = event.logins_today

    hour_range_hash = hour_ranges.each_with_object({}) do |hour_range, hash|
      hash[hour_range] = 0
    end

    logins_by_hour = logins_today.each do |login|
      created_at = Time.parse(login.fetch("keen").fetch("created_at"))

      correct_hour_range = hour_ranges.find { |hour_range| hour_range.cover? created_at }

      hour_range_hash[correct_hour_range] += 1
    end

    hour_range_hash.sort_by { |k, _| k.first }.map { |l| l.last }
  end

  def hour_ranges
    @_hour_ranges ||= begin
      today = Time.now.utc.strftime("%Y-%m-%d")

      0.upto(23).map do |hour|
        padded_hour = hour.to_s.rjust(2, "0")
        beginning   = Time.parse("#{today}T#{padded_hour}:00:00.000Z")
        ending      = Time.parse("#{today}T#{padded_hour}:59:59.999Z")

        beginning..ending
      end
    end
  end
end
