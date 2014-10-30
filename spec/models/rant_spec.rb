require "rails_helper"

describe Rant do
  context "validations" do
    it "requires a title of less than 50 characters" do
      rant = Rant.new(:title => "a"*51)
      rant.valid?

      expect(rant.errors[:title]).to_not be_empty

      rant.title = "a"*50
      rant.valid?

      expect(rant.errors[:title]).to be_empty
    end

    it "requires a rant to be at least 140 characters" do
      rant = Rant.new(:body => "a"*139)
      rant.valid?

      expect(rant.errors[:body]).to_not be_empty

      rant.body = "a"*140
      rant.valid?

      expect(rant.errors[:body]).to be_empty
    end
  end
end
