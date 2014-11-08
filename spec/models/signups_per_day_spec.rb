require "rails_helper"

describe SignupsPerDay do
  it "shows nothing if there are no users" do
    data = SignupsPerDay.new.as_json

    expected_data = {
      :labels => [],
      :datasets => []
    }

    expect(data).to eq(expected_data)
  end

  it "shows how many people have signed up per day when there are users" do
    create_user(:created_at => Date.parse("2012-01-01"))
    create_user(:created_at => Date.parse("2012-01-01"))
    create_user(:created_at => Date.parse("2012-01-01"))
    create_user(:created_at => Date.parse("2012-01-02"))
    create_user(:created_at => Date.parse("2012-01-05"))
    create_user(:created_at => Date.parse("2012-01-05"))

    data = SignupsPerDay.new
    data_hash = data.as_json

    expected_hash = {
      :labels => ["2012-01-01", "2012-01-02", "2012-01-03", "2012-01-04", "2012-01-05"],
      :datasets =>  [
        {
          :fillColor => "rgba(220,220,220,0.5)",
          :strokeColor => "rgba(220,220,220,0.8)",
          :highlightFill => "rgba(220,220,220,0.75)",
          :highlightStroke => "rgba(220,220,220,1)",
          :data => [3, 1, 0, 0, 2]
        }
      ]
    }

    expect(data_hash).to eq(expected_hash)
  end
end
