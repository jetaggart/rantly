require "rails_helper"

describe "Creating a rant" do
  it "allows a user to create a rant" do
    login_user(
      create_user(:username   => "psylinse",
                  :first_name => "Jeff",
                  :last_name  => "Taggart")
    )

    fill_in "A rant about:", :with => "I really hate testing"
    fill_in "Rant:", :with => "This is a really long rant"

    click_on "Rant"

    expect(page).to have_content("Rant created")
    expect(page).to have_content("My Rants")

    within("li", :text => "I really hate testing") do
      expect(page).to have_content("Jeff Taggart")
      expect(page).to have_content("This is a really long rant")
    end
  end

  it "allows a user to delete a rant" do
    login_user(
      create_user(:username   => "psylinse",
                  :first_name => "Jeff",
                  :last_name  => "Taggart")
    )

    fill_in "A rant about:", :with => "I really hate testing"
    fill_in "Rant:", :with => "This is a really long rant"

    click_on "Rant"

    click_on "Delete"

    expect(page).to have_content("Rant deleted")
    expect(page).to have_no_content("I really hate testing")
  end

  it "shows other users rants on the homepage" do
    other_user = create_user(:first_name => "John",
                             :last_name  => "Jankins")

    create_rant(:title  => "This is the other rant title",
                :body   => "This is some of the body",
                :author => other_user)

    login_user(create_user(:username => "psylinse"))

    expect(page).to have_content("Latest Rants")

    expect(page).to have_content("John Jankins")
    expect(page).to have_content("This is the other rant title")
    expect(page).to have_content("This is some of the body")
    expect(page).to have_no_content("Delete")
  end
end