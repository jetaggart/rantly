require "rails_helper"

describe "Viewing other users" do
  before do
    other_user = create_user(:first_name     => "John",
                             :last_name      => "Jankins",
                             :type_of_ranter => User.type_of_ranters[:daily],
                             :bio            => "This is the users bio")

    @rant = create_rant(:title  => "This is a rant title",
                        :body   => "This is a rant body"*50,
                        :author => other_user)

    login_user(create_user(:username => "psylinse"))
  end

  it "shows another users profile" do
    click_on "John Jankins"

    expect(page).to have_content("John Jankins")
    expect(page).to have_content("Daily Ranter")
    expect(page).to have_content("This is the users bio")

    expect(page).to have_content("This is a rant title")
    expect(page).to have_content("This is a rant body")

    visit rant_path(@rant)

    click_on "John Jankins"

    expect(page).to have_content("John Jankins")
  end

  it "allows a user to follow another user from their profile", :js => true do
    click_on "John Jankins"

    within("section", :text => "John Jankins") do
      click_on "Follow"
    end

    click_on "Following"

    expect(page).to have_content("John Jankins")
  end
end
