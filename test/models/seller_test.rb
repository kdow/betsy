require "test_helper"

describe Seller do
  let(:seller) { Seller.new }

  it "can add a product through .products" do
    prod = Product.new(name: "mousie", price: 300)
    seller_one = sellers(:kelly)
    seller_one.products << prod
    expect(seller_one.products).must_include prod
  end
end
