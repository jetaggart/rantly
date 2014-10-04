require "rails_helper"

describe "Creating a rant" do
  it "allows a user to create a rant" do
    login_user(
      create_user(:username => "psylinse",
                  :first_name => "Jeff",
                  :last_name => "Taggart")
    )

    fill_in "A rant about:", :with => "I really hate testing"
    fill_in "Rant:", :with => "This is a really long rant"

    click_on "Rant"

    expect(page).to have_content("Rant created")
    expect(page).to have_content("My Rants")

    within("li", :text => "I really hate testing") do
      expect(page).to have_content("Jeff Taggart")
      expect(page).to have_content("This is a really long rant")
    end
  end
end