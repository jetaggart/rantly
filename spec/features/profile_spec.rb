require "rails_helper"

describe "User editing their profile" do
  it "allows a user to click on their name to edit their profile" do
    pending("come back to me")
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

    expect(find("Username").value).to eq("psylinse")
    expect(find("Password").value).to be_empty
    expect(find("First name").value).to eq("Jeff")
    expect(find("Last name").value).to eq("Taggart")
    expect(find("Bio").value).to eq("This is my bio")
    expect(find("Weekly")).to be_checked
  end
end