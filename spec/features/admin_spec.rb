require "rails_helper"

describe "An admin user" do

  it "allows an admin to see a list of rants" do
    create_rant(:title => "Some rant title")
    create_rant(:title => "Another rant title")

    login_admin

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


    login_admin

    click_on "Users"

    within("tr", :text => "John Smith") do
      expect(page).to have_content("0")
    end

    within("tr", :text => "Sean Yonder") do
      expect(page).to have_content("1")
    end
  end

  it "allows an admin to search for rants within a certain range" do
    create_rant(:title => "Really far in the past", :created_at => 28.days.ago)
    create_rant(:title => "Today", :created_at => Time.now)
    create_rant(:title => "Yesterday", :created_at => 1.day.ago)

    login_admin
    click_on "Rants"

    expect(page).to have_content("Really far in the past")
    expect(page).to have_content("Today")
    expect(page).to have_content("Yesterday")

    fill_in "start_date", :with => ""
    fill_in "end_date", :with => 27.days.ago.end_of_day
    click_on "Filter"

    expect(page).to have_content("Really far in the past")
    expect(page).to have_no_content("Today")
    expect(page).to have_no_content("Yesterday")

    fill_in "start_date", :with => 28.days.ago.beginning_of_day
    fill_in "end_date", :with => 27.days.ago.end_of_day
    click_on "Filter"

    expect(page).to have_content("Really far in the past")
    expect(page).to have_no_content("Today")
    expect(page).to have_no_content("Yesterday")

    fill_in "start_date", :with => 3.days.ago.beginning_of_day
    fill_in "end_date", :with => 1.day.ago.end_of_day
    click_on "Filter"

    expect(page).to have_no_content("Really far in the past")
    expect(page).to have_no_content("Today")
    expect(page).to have_content("Yesterday")
    
    fill_in "start_date", :with => Time.now.beginning_of_day
    fill_in "end_date", :with => ""
    click_on "Filter"

    expect(page).to have_no_content("Really far in the past")
    expect(page).to have_content("Today")
    expect(page).to have_no_content("Yesterday")
    
    fill_in "start_date", :with => ""
    fill_in "end_date", :with => ""
    click_on "Filter"
 
    expect(page).to have_content("Really far in the past")
    expect(page).to have_content("Today")
    expect(page).to have_content("Yesterday")
  end

  it "allows an admin to view spam and resolve it or delete it" do
    create_rant(:title => "Rant that's not spam", :spam => false)
    create_rant(:title => "Spam to delete", :spam => true)
    create_rant(:title => "Spam to resolve", :spam => true)

    login_admin

    click_on "Rants"

    expect(page).to have_content("Rant that's not spam")
    expect(page).to have_no_content("Spam to delete")
    expect(page).to have_no_content("Spam to resolve")

    click_on "Spam"

    expect(page).to have_no_content("Rant that's not spam")
    expect(page).to have_content("Spam to delete")
    expect(page).to have_content("Spam to resolve")

    within("tr", :text => "Spam to resolve") do
      click_on "Not spam"
    end

    within("tr", :text => "Spam to delete") do
      click_on "Delete"
    end

    expect(page).to have_no_content("Rant that's not spam")
    expect(page).to have_no_content("Spam to delete")
    expect(page).to have_no_content("Spam to resolve")

    click_on "All"

    expect(page).to have_content("Rant that's not spam")
    expect(page).to have_content("Spam to resolve")
  end

  it "shows the admin charts" do
    login_admin

    expect(page).to have_content("Rants per Day")
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

  def login_admin
    login_user(create_user(:admin => true))
  end

end
