require "rails_helper"

describe UsersController do
  context "GET #show" do
    it "returns the users rants ordered by favorite" do
      other_user = create_user
      user       = create_user

      rant1 = create_rant(:author => user)
      rant2 = create_rant(:author => user)
      rant3 = create_rant(:author => user)

      3.times { rant2.favorites.create!(:user => other_user) }
      2.times { rant3.favorites.create!(:user => other_user) }
      1.times { rant1.favorites.create!(:user => other_user) }

      allow(controller).to receive(:current_user).and_return(user)
      get :show, :id => user

      expected_order = [rant2.id, rant3.id, rant1.id]
      expect(assigns(:rants).map(&:id)).to eq(expected_order)
    end
  end
end
