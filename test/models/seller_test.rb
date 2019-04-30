require "test_helper"

describe Seller do
  let(:seller) { Seller.new }

  it "must be valid" do
    value(seller).must_be :valid?
  end
end
