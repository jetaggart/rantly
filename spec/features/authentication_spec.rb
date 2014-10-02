require "rails_helper"

describe "User authenticating with the site" do
  it "doesn't allow a user to login that doesn't exist" do
    visit root_path

    click_on "Login"

    within("form") do
      click_on "Login"
    end

    expect(page).to have_content("Invalid username or password")
  end

  it "doesn't allow a non-logged in user to see the dashboard" do
    visit dashboard_path

    expect(page).to have_content("You're not allowed to access that page. Please sign up to continue.")
  end

  it "allows a logged in user to log out" do
    User.create!(:username => "psylinse", :password => "password")

    visit root_path

    click_on "Login"


    within("form") do
      fill_in "Username", :with => "psylinse"
      fill_in "Password", :with => "password"
      click_on "Login"
    end

    click_on "Logout"

    expect(page).to have_content("Logged out successfully")

    visit dashboard_path

    expect(page).to have_content("You're not allowed to access that page.")
  end
end
