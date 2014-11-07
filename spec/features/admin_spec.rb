require "rails_helper"

describe "An admin user" do

  it "allows an admin to see a list of rants" do
    create_rant(:title => "Some rant title")
    create_rant(:title => "Another rant title")

    login_user(create_user(:admin => true))

    click_on "Rants"

    expect(page).to have_content("Some rant title")
    expect(page).to have_content("Another rant title")
  end

  it "allows an admin to disable a user" do
    jeff = create_user(:first_name => "Jeff")
    
    admin = create_user(:admin => true)
    login_user(admin)

    click_on "Users"

    within("tr", :text => "Jeff") do
      click_on "Disable"
    end

    click_on "Logout"
    login_user(jeff)

    expect(page).to have_content("Account is disabled")

    login_user(admin)

    click_on "Users"

    within("tr", :text => "Jeff") do
      click_on "Enable"
    end

    click_on "Logout"
    login_user(jeff)

    expect(page).to have_content("Welcome, #{jeff.username}")
  end

  it "allows an admin to see a list of users" do
    create_user(:first_name => "John",
                :last_name  => "Smith")
    sean = create_user(:first_name => "Sean",
                       :last_name  => "Yonder")

    create_rant(:author => sean)


    login_user(create_user(:admin => true))

    expect(page).to have_content("Dashboard")

    click_on "Users"

    within("tr", :text => "John Smith") do
      expect(page).to have_content("0")
    end

    within("tr", :text => "Sean Yonder") do
      expect(page).to have_content("1")
    end
  end

  it "allows an admin to sort users by rants written" do
    user = create_user(:first_name => "Jeff")
    create_rant(:author => user)
    create_rant(:author => user)

    user = create_user(:first_name => "John")
    create_rant(:author => user)

    login_user(create_user(:first_name => "Admin",
                           :admin => true))

    click_on "Users"

    first_tr = all("tr")[1]
    within(first_tr) do
      expect(page).to have_content("Jeff")
    end

    click_on "Number of Rants"

    first_tr = all("tr")[1]
    within(first_tr) do
      expect(page).to have_content("Admin")
    end

    second_tr = all("tr")[2]
    within(second_tr) do
      expect(page).to have_content("John")
    end
  end
end
