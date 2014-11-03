require "rails_helper"

describe "Visiting the home page" do
  it "shows the homepage" do
    visit root_path

    expect(page).to have_content("Rantly")
    expect(page).to have_content("Let it all out")
    expect(page).to have_content("Jeff Taggart")
    expect(page).to have_content("Rantly has allowed")
  end

  it "shows a welcome back message" do
    visit root_path

    expect(page).to have_no_content("Welcome back! Consider joining.")

    visit root_path

    expect(page).to have_content("Welcome back! Consider joining.")

  end

  it "allows a user to register and log in" do
    visit root_path

    click_on "Join"

    expect(page).to have_content("Register")

    fill_in "Username", :with => "psylinse"
    fill_in "Password", :with => "password"
    fill_in "First name", :with => "Jeff"
    fill_in "Last name", :with => "Taggart"
    fill_in "Bio", :with => "This is my awesome bio please listen to me I'm awesome a ranting"

    choose "Weekly"

    click_on "Register"

    expect(page).to have_content("Thank you for registering")

    click_on "Login"

    within("form") do
      fill_in "Username", :with => "psylinse"
      fill_in "Password", :with => "password"
      click_on "Login"
    end
    
    expect(page).to have_content("Welcome, psylinse")
    expect(page).to have_content("My Rants")

    expect(page).to have_no_content("Login")
    expect(page).to have_no_content("Join")
  end

  it "shows registration errors" do
    visit root_path

    click_on "Join"

    click_on "Register"

    expect(page).to have_content("Username can't be blank")
    expect(page).to have_content("Password can't be blank")
  end

end
