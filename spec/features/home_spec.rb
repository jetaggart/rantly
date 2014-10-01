require "rails_helper"

describe "Visiting the home page" do
  it "shows the homepage" do
    visit root_path

    expect(page).to have_content("Rantly")
    expect(page).to have_content("Let it all out")
    expect(page).to have_content("Jeff Taggart")
    expect(page).to have_content("Rantly has allowed")
  end

  it "allows me to register" do
    visit root_path

    click_on "Join"

    expect(page).to have_content("Register")

    fill_in "Username", :with => "psylinse"
    fill_in "Password", :with => "password"
    fill_in "First name", :with => "Jeff"
    fill_in "Last name", :with => "Taggart"
    fill_in "Bio", :with => "This is my awesome bio please listen to me I'm awesome a ranting"

    choose "weekly"

    click_on "Register"

    expect(page).to have_content("Thank you for registering")
  end
end
