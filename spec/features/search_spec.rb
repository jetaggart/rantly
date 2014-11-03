require "rails_helper"

describe "A user searching for rants" do
  def search(query)
    user = create_user(:first_name => "Jeff",
                       :last_name  => "Taggart",
                       :username   => "psylinse")

    create_rant(:author => user, :title => "Find me!")
    create_rant(:title => "Don't find me")

    login_user(user)

    within("nav") do
      click_on "Search"
    end

    expect(page).to have_no_content("Find me!")
    expect(page).to have_no_content("Don't find me")

    within("section.search") do
      fill_in "search[query]", :with => query
      click_on "Search"
    end
  end

  it "allows a user to search by last name" do
    search("Taggart")

    expect(page).to have_content("Find me!")
    expect(page).to have_no_content("Don't find me")
  end

  it "allows a user to search by first name" do
    search("Jeff")

    expect(page).to have_content("Find me!")
    expect(page).to have_no_content("Don't find me")
  end

  it "allows a user to search by first name" do
    search("psylinse")

    expect(page).to have_content("Find me!")
    expect(page).to have_no_content("Don't find me")
  end

end
