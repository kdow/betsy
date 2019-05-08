require "test_helper"

describe Product do
  let(:product) { products(:crown) }
  let(:bouquet) { products(:bouquet) }

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

  describe "custome method adjust quantity" do
    it "adjust the quantity of the inventory" do
      item = order_products(:two)
      order_products = []
      order_products << item

      product = Product.find_by(id: item.product.id)
      start_quantity = product.quantity

      Product.adjust_quantity(order_products)

      product = Product.find_by(id: item.product.id)
      end_quantity = product.quantity

      expect(start_quantity - end_quantity).must_equal item.quantity
    end

    describe "custome method check quantity" do
      it "return false if there is not enough quantity" do
        item = order_products(:one)
        product.quantity = 0
        product.save
        order_products = []
        order_products << item
        expect(Product.check_quantity(order_products)).must_equal false
      end
      it "returns true if there are enough quantity" do
        item = order_products(:one)
        order_products = []
        order_products << item
        expect(Product.check_quantity(order_products)).must_equal true
      end
    end
  end

  describe "validations" do
    it "must be valid" do
      expect(product).must_be :valid?
    end
    it "should have a name" do
      product.name = nil
      result = product.save
      expect(result).must_equal false
      expect(product.errors.messages).must_include :name
      expect(product.errors.messages[:name]).must_equal ["can't be blank"]
    end
    it "requires a unique name" do
      product.name = bouquet.name
      result = product.valid?
      expect(result).must_equal false
      expect(product.errors.messages).must_include :name
    end
    it "requires a price greater than zero" do
      product.price = 0
      result = product.valid?
      expect(result).must_equal false
      expect(product.errors.messages).must_include :price
    end
    it "needs the price to be an integer" do
      product.price = "string"
      result = product.save
      expect(result).must_equal false
      expect(product.errors.messages).must_include :price
    end
  end

  describe "self.active" do
    it "returns a collection of active products" do
      products = [product, bouquet]
      bouquet.is_active = false
      bouquet.save

      active_products = Product.active(products)

      expect(active_products).must_be_instance_of Array
      expect(active_products.first).must_equal product
      expect(active_products.first.is_active).wont_equal false
      expect(active_products.length).must_equal 1
    end
  end
end
