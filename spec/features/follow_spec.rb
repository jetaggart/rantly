require "rails_helper"

describe "User following another user" do
  it "allows a user to follow and unfollow another user" do
    other_user = create_user(:first_name => "Follow", :last_name => "Me")
    create_rant(:author => other_user)

    login_user(create_user)

    expect(page).to have_content("Follow Me")
    click_on "Follow"

    expect(page).to have_content("You are now following Follow Me")
    click_on "Following"

    expect(page).to have_content("Follow Me")

    visit dashboard_path

    click_on "Unfollow"
    expect(page).to have_content("You are no longer following Follow Me")

    click_on "Following"
    expect(page).to have_no_content("Follow Me")

    visit dashboard_path
    click_on "Follow"

    click_on "Following"

    click_on "Unfollow"
    expect(page).to have_content("You are no longer following Follow Me")

    click_on "Following"
    expect(page).to have_no_content("Follow Me")
  end

end

