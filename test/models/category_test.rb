require "test_helper"

describe Category do
  let(:category) { categories(:toys) }

  describe "validations" do
    it "must be valid" do
      category = categories(:toys)

      valid_category = category.valid?

      expect(valid_category).must_equal true
    end

    it "requires a name" do
      category.name = nil

      category.valid?.must_equal false

      expect(category.errors.messages).must_include :name
      expect(category.errors.messages[:name]).must_equal ["can't be blank"]
    end
    it "requires a unique name" do
      category = Category.new(name: "Toys")
      result = category.valid?

      expect(result).must_equal false
      expect(category.errors.messages).must_include :name
    end
  end
end
