require "test_helper"

describe OrderProductsController do
  let (:seller) {
    Seller.create username: "kittin mittin seller", email: "Kitty@email.com"
  }
  let (:product) {
    Product.create name: "kittin mittins", description: "paw warmers", price: 1200, seller_id: seller.id
  }

  let(:order_product) {
    order_product.create(quantity: 2, product_id: product.id)
  }
  describe "create" do
    it "can make a new order product " do
      product = products(:bouquet)
      order_product_hash = {
        order_product: {
          quantity: 2,
          product_id: product.id,
        },
      }
      expect {
        post order_products_path, params: order_product_hash
      }.must_change "order_product.count", 1

      new_order_product = Product.find_by(product_id: order_product_hash[:order_product][:product_id])
      expect(new_order_product.product.name).must_equal "bouquet"
      expect(new_order_product.quantity).must_equal 2
    end
  end

  describe "update" do
    it "can update item quantities in cart" do
      @order = current_order
      
    end
  end
end
