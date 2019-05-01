require "test_helper"

describe OrderProduct do
  let(:order_product) { OrderProduct.new }

  it "must be valid" do
    value(order_product).must_be :valid?
  end

  describe "relations" do
    it "has an order" do
      order_prod = order_products(:two)
      order_prod.order.must_equal orders(:one)
    end

    it "can set the order" do
      order_prod = OrderProduct.new(quantity: 1)
      order_prod.order = orders(:one)
      order_prod.order_id.must_equal orders(:one).id
    end

    it "has a product" do
      order_prod = order_products(:two)
      order_prod.product.must_equal products(:bouquet)
    end

    it "can set the product" do
      order_prod = OrderProduct.new(quantity: 1)
      order_prod.product = products(:crown)
      order_prod.product_id.must_equal products(:crown).id
    end
  end
end
