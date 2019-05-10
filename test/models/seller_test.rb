require "test_helper"

describe Seller do
  let(:seller) { sellers(:sarah) }
  let(:kelly) { sellers(:sarah) }
  let(:new_seller) { sellers(:new_seller) }

  describe "validations" do
    it "should have a username" do
      seller.username = nil
      result = seller.valid?
      expect(result).must_equal false
    end
    it "must have unique username" do
      new_seller.username = "sarah"
      result = new_seller.valid?
      expect(result).must_equal false
      expect(new_seller.errors.messages).must_include :username
    end
    it "must have an email" do
      seller.email = nil
      result = seller.valid?
      expect(result).must_equal false
    end
    it "must have a unique email" do
      new_seller.email = "sarah@cats.com"
      result = new_seller.valid?
      expect(result).must_equal false
      expect(new_seller.errors.messages).must_include :email
    end
  end

  it "can add a product through .products" do
    prod = Product.new(name: "mousie", price: 300)
    seller_one = sellers(:kelly)
    seller_one.products << prod
    expect(seller_one.products).must_include prod
  end

  describe "get_unique_orders" do
    it "returns an array of orders " do
      orders = seller.get_unique_orders

      expect(orders).must_be_instance_of Array
      expect(orders.first).must_be_instance_of Order
    end

    it "returns an emply array if there are no orders " do
      expect(new_seller.get_unique_orders).must_equal []
    end
  end

  describe "order_revenue" do
    before do
      @order = orders(:new_order)
    end

    it "returns the sum of order_products belonging to the seller" do
      expect(seller.order_revenue(@order)).must_equal 6000
    end

    it "return zero if there are no order products belonging to the seller" do
      expect(new_seller.order_revenue(@order)).must_equal 0
    end

    it "returns zero if there are no order_products for the order" do
      empty_order = orders(:empty_order)
      expect(seller.order_revenue(empty_order)).must_equal 0
    end
  end
  describe "total_revenue_by_status" do
    it "returns the sum of seller revenue from all orders of a givin status" do
      expect(seller.total_revenue_by_status("in progress")).must_equal 12000
    end

    it "returns 0 if there are no order with given status" do
      expect(seller.total_revenue_by_status("shipped")).must_equal 0
    end
  end
end
