require "test_helper"

describe Order do
  let(:kitcat) { orders(:kitcat) }
  let(:catter) { orders(:catter) }

  # it "must be valid" do
  #   value(order).must_be :valid?
  #  end
  describe "validations" do
    it "must be valid" do
      expect(kitcat.valid?).must_equal true
    end
    it "requires a name" do
      kitcat.name = nil
      kitcat.valid?.must_equal false
      expect(kitcat.errors.messages).must_include :name
      expect(kitcat.errors.messages[:name]).must_equal ["can't be blank"]
    end
    it "requires an email" do
      kitcat.email = nil
      kitcat.valid?.must_equal false
      expect(kitcat.errors.messages).must_include :email
      expect(kitcat.errors.messages[:email]).must_equal ["can't be blank"]
    end
    it "requires an address" do
      kitcat.address = nil
      kitcat.valid?.must_equal false
      expect(kitcat.errors.messages).must_include :address
      expect(kitcat.errors.messages[:address]).must_equal ["can't be blank"]
    end
    it "requires a credit card number" do
      kitcat.last_four = nil
      kitcat.valid?.must_equal false
      expect(kitcat.errors.messages).must_include :last_four
      expect(kitcat.errors.messages[:last_four]).must_equal ["can't be blank"]
    end
    it "requires an expiration date for credit card" do
      kitcat.cc_exp = nil
      kitcat.valid?.must_equal false
      expect(kitcat.errors.messages).must_include :cc_exp
      expect(kitcat.errors.messages[:cc_exp]).must_equal ["can't be blank"]
    end
    it "requires a cvv number" do
      kitcat.cvv = nil
      kitcat.valid?.must_equal false
      expect(kitcat.errors.messages).must_include :cvv
      expect(kitcat.errors.messages[:cvv]).must_equal ["can't be blank"]
    end
    it "requires a city" do
      kitcat.city = nil
      kitcat.valid?.must_equal false
      expect(kitcat.errors.messages).must_include :city
      expect(kitcat.errors.messages[:city]).must_equal ["can't be blank"]
    end
    it "requires a state" do
      kitcat.state = nil
      kitcat.valid?.must_equal false
      expect(kitcat.errors.messages).must_include :state
      expect(kitcat.errors.messages[:state]).must_equal ["can't be blank"]
    end
    it "requires a zip code" do
      kitcat.zip = nil
      kitcat.valid?.must_equal false
      expect(kitcat.errors.messages).must_include :zip
      expect(kitcat.errors.messages[:zip]).must_equal ["can't be blank"]
    end
  end
  describe "relations" do
    it "has a list of order_products" do
      order = orders(:one)
      expect(order.order_products.length).must_equal 2
      order.order_products.each do |product|
        product.must_be_kind_of OrderProduct
      end
    end
    it "can add an order_product through .order_products" do
      order_prod = OrderProduct.new(quantity: 1)
      order_one = orders(:one)
      order_one.order_products << order_prod
      expect(order_one.order_products).must_include order_prod
    end
  end

  describe "calculate total" do
    it "can calculate the total price for the order" do
      order = orders(:one)
      expect(order.calculate_total).must_equal 12000
    end
  end
end
