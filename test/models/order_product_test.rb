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
  describe "already in the cart" do
    it "returns true if the item exist in the cart" do
      order = orders(:one)
      order_product = order_products(:one)
      result = OrderProduct.already_in_cart?(order_product, order)
      expect(result).must_equal true
    end
    it "returns false if the item does not exist in the cart" do
      order = orders(:two)
      order_product = order_products(:one)
      result = OrderProduct.already_in_cart?(order_product, order)
      expect(result).must_equal false
    end
  end
  describe "validations" do
    it "must have a quantity" do
      order_product = order_products(:one)
      order_product.quantity = nil
      expect(order_product.valid?).must_equal false
      expect(order_product.errors.messages).must_include :quantity
    end
    it "must have a quantity greater than zero" do
      order_product = order_products(:one)
      order_product.quantity = 0
      expect(order_product.valid?).must_equal false
      expect(order_product.errors.messages).must_include :quantity
    end

    it "can only have an integer as quantity" do
      order_product = order_products(:one)
      order_product.quantity = "string"
      expect(order_product.valid?).must_equal false
      expect(order_product.errors.messages).must_include :quantity
    end
  end
end
