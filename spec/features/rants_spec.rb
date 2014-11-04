require "rails_helper"

describe "Creating a rant", :js => true do
  it "allows a user to create a rant" do
    login_user(
      create_user(:username   => "psylinse",
                  :first_name => "Jeff",
                  :last_name  => "Taggart")
    )

    fill_in "A rant about:", :with => "I really hate testing"
    fill_in "Rant:", :with => "This is a really long rant"*50

    click_on "Rant"

    expect(page).to have_content("Rant created")
    expect(page).to have_content("My Rants")

    within("li", :text => "I really hate testing") do
      expect(page).to have_content("Jeff Taggart")
      expect(page).to have_content("This is a really long rant")
    end
  end

  it "shows errors on the rant form" do
    login_user(
      create_user(:username   => "psylinse")
    )

    click_on "Rant"

    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end

  it "allows a user to favorite a rant" do
    create_rant(:body => "This is a rant that is to be favorited "*50)

    login_user(
      create_user(:username   => "psylinse")
    )

    click_on "This is a rant that is to be favorited"

    within("section", :text => "This is a rant") do
      click_on "Favorite"
    end

    click_on "Favorites"

    expect(page).to have_content("This is a rant that is to be favorited")

    click_on "This is a rant"
    click_on "Unfavorite"
    click_on "Favorites"

    expect(page).to have_no_content("This is a rant that is to be favorite")

    visit dashboard_path

    within("section", :text => "This is a rant that is to be favorited") do
      click_on "Favorite"
    end

    click_on "Favorites"

    expect(page).to have_content("This is a rant that is to be favorite")
  end

  it "allows a user to delete a rant" do
    login_user(
      create_user(:username   => "psylinse")
    )

    fill_in "A rant about:", :with => "I really hate testing"
    fill_in "Rant:", :with => "This is a really long rant"*50

    click_on "Rant"

    click_on "Delete"

    expect(page).to have_content("Rant deleted")
    expect(page).to have_no_content("I really hate testing")
  end

  it "allows markdown in the rant body" do
    login_user(
      create_user(:username   => "psylinse")
    )

    fill_in "A rant about:", :with => "I really hate testing"
    fill_in "Rant:", :with => """
# This

## is a rant

* that contains markdown
* and should be rendered as such
* I need it to be long enough though
* so I'll keep talking about stuff
    """

    click_on "Rant"

    within("section.my-rants") do
      h1 = find("h1")

      expect(h1).to have_text("This")
    end

  end
  
  it "shows other users rants on the homepage" do
    other_user = create_user(:first_name => "John",
                             :last_name  => "Jankins")

    create_rant(:title  => "This is the other rant title",
                :body   => "This is some of the body"*50,
                :author => other_user)

    create_rant(:title  => "This is the second rant from the other user",
                :author => other_user)

    login_user(create_user(:username => "psylinse"))

    expect(page).to have_content("Latest Rants")

    expect(page).to have_content("John Jankins")
    expect(page).to have_content("This is the other rant title")
    expect(page).to have_content("This is some of the body")
    expect(page).to have_no_content("Delete")

    expect(page).to have_content("This is the second rant from the other user")

    click_on("This is the other rant title")

    expect(page).to have_content("John Jankins")
    expect(page).to have_content("This is the other rant title")
    expect(page).to have_content("This is some of the body")

    expect(page).to have_no_content("This is the second rant from the other user")
  end
end
