require "rails_helper"

describe "Viewing other users" do
  it "shows another users profile" do
    other_user = create_user(:first_name     => "John",
                             :last_name      => "Jankins",
                             :type_of_ranter => User.type_of_ranters[:daily],
                             :bio            => "This is the users bio")

    create_rant(:title  => "This is a rant title",
                :body   => "This is a rant body",
                :author => other_user)

    login_user(create_user(:username => "psylinse"))

    click_on "John Jankins"

    expect(page).to have_content("John Jankins")
    expect(page).to have_content("Daily Ranter")
    expect(page).to have_content("This is the users bio")

    expect(page).to have_content("This is a rant title")
    expect(page).to have_content("This is a rant body")
  end
end
