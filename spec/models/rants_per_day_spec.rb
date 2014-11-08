require "rails_helper"

describe RantsPerDay do
  it "returns properly formatted hash for chartjs" do
    create_rant(:created_at => Date.parse("2012-01-01"))
    create_rant(:created_at => Date.parse("2012-01-01"))
    create_rant(:created_at => Date.parse("2012-01-01"))
    create_rant(:created_at => Date.parse("2012-01-02"))
    create_rant(:created_at => Date.parse("2012-01-05"))
    create_rant(:created_at => Date.parse("2012-01-05"))


    data = RantsPerDay.new

    data_hash = data.as_json

    expected_hash = {
      :labels => ["2012-01-01", "2012-01-02", "2012-01-03", "2012-01-04", "2012-01-05"],
      :datasets =>  [
        {
          :label => "Rants per Day",
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

  it "returns nothing if there are no rants" do
    data = RantsPerDay.new

    data_hash = data.as_json

    expected_hash = {
      :labels => [],
      :datasets =>  []
    }

    expect(data_hash).to eq(expected_hash)
  end
end
