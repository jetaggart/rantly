require "rails_helper"

describe "User following another user", :js => true do
  def login_and_follow
    @other_user = create_user(:username => "some-username",
                              :first_name => "Follow",
                              :last_name => "Me")
    create_rant(:author => @other_user, :title => "This is a rant to be held")

    @user = create_user(:email => "test@example.com")
    login_user(@user)

    expect(page).to have_content("Follow Me")
    click_on "Follow"
  end

  it "allows a user to follow and unfollow another user" do
    login_and_follow

    click_on "Following"

    expect(page).to have_content("Follow Me")

    visit dashboard_path

    click_on "Unfollow"

    click_on "Following"
    expect(page).to have_no_content("Follow Me")

    visit dashboard_path
    click_on "Follow"

    click_on "Following"

    click_on "Unfollow"

    click_on "Following"
    expect(page).to have_no_content("Follow Me")
  end

  it "sends an email to followers when an email rants" do
    login_and_follow

    click_on "Logout"

    login_user(@other_user)

    fill_in "A rant about:", :with => "I really hate testing"
    fill_in "Rant:", :with => "This is a rant"*80
    click_on "Rant"

    expect(page).to have_content("I really hate testing")

    open_email("test@example.com")
    expect(current_email).to have_content("some-username has just posted a new rant")
  end
end

