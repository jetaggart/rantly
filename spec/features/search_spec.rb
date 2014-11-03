require "rails_helper"

describe "A user searching for rants" do
  it "allows a user to search by last name" do
    user = create_user(:last_name => "Taggart")
    create_rant(:author => user, :title => "Find me!")
    create_rant(:title => "Don't find me")

    login_user(user)

    within("nav") do
      click_on "Search"
    end

    expect(page).to have_no_content("Find me!")
    expect(page).to have_no_content("Don't find me")

    within("section.search") do
      fill_in "search[query]", :with => "Taggart"
      click_on "Search"
    end

    expect(page).to have_content("Find me!")
    expect(page).to have_no_content("Don't find me")
  end
end
