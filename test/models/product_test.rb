require "test_helper"

# describe Product do
#   let(:product) { Product.new }

<<<<<<< HEAD
#   it "must be valid" do
#     value(product).must_be :valid?
#   end
# end
=======
  it "must be valid" do
    value(product).must_be :valid?
  end

  describe "relations" do
    it "has a seller" do
      prod = products(:crown)
      prod.seller.must_equal sellers(:kelly)
    end

    it "can set the seller" do
      prod = Product.new(name: "mousie", price: 300)
      prod.seller = sellers(:sarah)
      prod.seller_id.must_equal sellers(:sarah).id
    end

    it "can add an order_product through .order_products" do
      order_prod = OrderProduct.new(quantity: 1)
      product_one = products(:crown)
      product_one.order_products << order_prod
      expect(product_one.order_products).must_include order_prod
    end
  end
end
>>>>>>> d40f013654073a3cd48250d1389de2de9699774f
