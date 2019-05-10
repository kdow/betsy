require "test_helper"

describe Seller do
  let(:seller) { sellers(:sarah) }
  let(:kelly) { sellers(:sarah) }
  let(:new_seller) { sellers(:new_seller) }

  describe "relationships" do
    it "can add a product through .products" do
      prod = Product.new(name: "mousie", price: 300)
      seller_one = sellers(:kelly)
      seller_one.products << prod
      expect(seller_one.products).must_include prod
    end

    it "can get an list of orders through .orders" do
      orders = seller.orders
      expect(orders.first).must_be_instance_of Order
      expect(orders).must_include orders(:completed)
    end

    it "can get a list of order_products through .order_products" do
      order_products = seller.order_products
      expect(order_products.first).must_be_instance_of OrderProduct
      expect(order_products.first.product.seller).must_equal seller
      expect(order_products).must_include order_products("completed-3")
    end
  end

  describe "validations" do
    before do
      @another_seller = Seller.new(
        {
          username: "Fluffer Nutter",
          email: "fluffy@kitties.com",
          uid: 3447584,
          provider: "Github",
        }
      )
    end
    it "is valid when all fields are valid" do
      result = @another_seller.valid?

      expect(result).must_equal true
    end
    it "Is invalid when a username is blank" do
      @another_seller.username = nil
      result = @another_seller.valid?

      expect(result).must_equal false
    end
    it "Is invalid when a username is not unique" do
      @another_seller.username = seller.username
      result = @another_seller.valid?

      expect(result).must_equal false
    end
    it "Is invalid when an email is blank" do
      @another_seller.email = nil
      result = @another_seller.valid?

      expect(result).must_equal false
    end
    it "Is invalid when an email is not unique" do
      @another_seller.email = seller.email
      result = @another_seller.valid?

      expect(result).must_equal false
    end
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

    it "returns 0 if there are no orders with given status" do
      expect(seller.total_revenue_by_status("paid")).must_equal 0
    end
    it "returns 0 if given a bogus status" do
      expect(seller.total_revenue_by_status("fake status")).must_equal 0
    end
  end
  describe "total_items_sold" do
    it "returns the correct number of items" do
      expect(seller.total_items_sold).must_equal 4
    end
    it "returns 0 if the seller has no orders" do
      expect(new_seller.total_items_sold).must_equal 0
    end
    it "returns 0 if the seller has no complete orders" do
      catnip_seller = sellers(:catnip_seller)
      expect(catnip_seller.total_items_sold).must_equal 0
    end
  end
end
