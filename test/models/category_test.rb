require "test_helper"

describe Category do
  let(:category) { categories(:toys) }

  describe "validations" do
    it "must be valid" do
      category = categories(:toys)

      valid_category = category.valid?

      expect(valid_category).must_equal true
    end
  end
end
