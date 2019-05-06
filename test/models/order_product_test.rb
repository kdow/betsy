require "test_helper"

describe OrderProduct do
  #   let(:order_product) { OrderProduct.new }

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

  describe "line_item_subtotal" do
    it "returns the correct total" do
      order_prod = order_products(:two)
      order_prod.quantity = 2
      order_prod.product.price = 200
      expect(order_prod.line_item_subtotal).must_equal 400
    end

    it "returns zero if quantity is zero" do
      order_prod = order_products(:two)
      order_prod.quantity = 0
      order_prod.product.price = 300
      expect(order_prod.line_item_subtotal).must_equal 0
    end
  end
end
