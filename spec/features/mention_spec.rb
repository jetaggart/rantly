require "rails_helper"

describe "A user receiving a mention" do

  it "shows the mention on the homepage" do
    create_rant(:title => "This is the rant with a mention",
                :body => "This is a body with a mention @psylinse"*8)

    create_rant(:title => "This is a different rant",
                :body => "This is a body with a mention @linse"*8)

    login_user(
      create_user(:username => "psylinse")
    )

    within("section", :text => "Mentioned") do
      expect(page).to have_content("This is the rant with a mention")
      expect(page).to have_no_content("This is a different rant")
    end
  end

end
