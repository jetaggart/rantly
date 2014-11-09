require "rails_helper"

describe LoginsPerHour do
  class FakeEvent
    def self.logins_today
      [
        {
          "username"=>"psylinse1",
          "keen" => {
            "timestamp" => "2014-11-09T20:25:56.096Z",
            "created_at" => "2014-11-09T20:25:56.096Z",
            "id" => "545fcdd4bcb79c150002b2d8"
          }
        }, {
          "username"=>"another",
          "keen" => {
            "timestamp" => "2014-11-09T21:25:56.096Z",
            "created_at" => "2014-11-09T21:25:56.096Z",
            "id" => "545fcdd4bcb79c150002b2d8"
          }
        }, {
          "username"=>"another blue",
          "keen" => {
            "timestamp" => "2014-11-09T21:59:59.999Z",
            "created_at" => "2014-11-09T21:59:59.999Z",
            "id" => "545fcdd4bcb79c150002b2d8"
          }
        }, {
          "username"=>"early morning",
          "keen" => {
            "timestamp" => "2014-11-09T00:59:59.999Z",
            "created_at" => "2014-11-09T00:59:59.999Z",
            "id" => "545fcdd4bcb79c150002b2d8"
          }
        }

      ]
    end
  end

  it "returns a properly formatted hash for chartjs" do
    data = LoginsPerHour.new(FakeEvent).as_json

    expected_hash = {
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
          :data => [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0]
        }
      ]
    }

    expect(data).to eq(expected_hash)
  end
end
