require "rails_helper"

describe "User editing their profile" do
  it "allows a user to click on their name to edit their profile" do
    user = create_user(
      :username       => "psylinse",
      :first_name     => "Jeff",
      :last_name      => "Taggart",
      :password       => "password",
      :bio            => "This is my bio",
      :type_of_ranter => User.type_of_ranters[:weekly]
    )

    login_user(user)

    click_on "Jeff Taggart"

    expect(find_field("Username").value).to eq("psylinse")
    expect(find_field("Password").value).to eq(nil)
    expect(find_field("First name").value).to eq("Jeff")
    expect(find_field("Last name").value).to eq("Taggart")
    expect(find_field("Bio").value).to eq("This is my bio")
    expect(find_field("Weekly")).to be_checked

    fill_in "Username", :with => "jetaggart"
    fill_in "First name", :with => "Chris"
    fill_in "Last name", :with => "Johnson"
    fill_in "Bio", :with => "This is my new bio"

    click_on "Update"

    expect(page).to have_content("Profile updated")

    click_on "Chris Johnson"

    expect(find_field("Username").value).to eq("jetaggart")
    expect(find_field("Bio").value).to eq("This is my new bio")
  end
end