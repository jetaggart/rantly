require "rails_helper"

describe "An admin user" do
  it "allows a admin to see a list of users" do
    create_user(:first_name => "John",
                :last_name  => "Smith")
    sean = create_user(:first_name => "Sean",
                       :last_name  => "Yonder")

    create_rant(:author => sean)

    admin_user = create_user(:username => "admin",
                             :password => "admin123",
                             :admin    => true)

    login_user(admin_user)

    expect(page).to have_content("Dashboard")

    click_on "Users"

    within("tr", :text => "John Smith") do
      expect(page).to have_content("0")
    end

    within("tr", :text => "Sean Yonder") do
      expect(page).to have_content("1")
    end
  end
end