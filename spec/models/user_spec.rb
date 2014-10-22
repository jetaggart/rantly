require "rails_helper"

describe User do
  context "validations" do
    let(:user) { User.new }

    before do
      user.valid?
    end

    it "validates username presence" do
      expect(user.errors[:username]).to be_present
    end

    it "validates username uniqueness" do
      create_user(:username => "psylinse")

      user.username = "psylinse"
      user.valid?
      
      expect(user.errors[:username]).to be_present
    end

    it "validates password presence" do
      expect(user.errors[:password]).to be_present
    end

    it "validates password length" do
      user.password = "1234567"
      expect(user.errors[:password]).to be_present

      user.password = "12345678"
      user.valid?
      expect(user.errors[:password]).to be_empty
    end

    it "validates type_of_ranter presence" do
      expect(user.errors[:type_of_ranter]).to be_present
    end

    it "validates bio presence" do
      expect(user.errors[:bio]).to be_present
    end

    it "validates first_name presence" do
      expect(user.errors[:first_name]).to be_present
    end

    it "validates last_name presence" do
      expect(user.errors[:last_name]).to be_present
    end
  end
end
