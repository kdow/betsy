require "test_helper"

describe ProductsController do
  let (:seller) {
    Seller.create username: "kittin mittin seller", email: "Kitty@email.com"
  }
  let (:product) {
    Product.create name: "kittin mittins", description: "paw warmers", price: 1200, seller_id: seller.id
  }

  describe "index" do
    it "can get the index page" do
      get products_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "Can get a product with a valid id" do
      get products_path(product.id)

      must_respond_with :success
    end

    it "Will redirect if given an invalid product ID" do
      get product_path(-1)

      must_respond_with :not_found
    end
  end
  describe "new" do
    it "can get the new product page" do
      get new_product_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new product" do
      product_hash = {
        product: {
          name: "Kitty tower",
          price: 1300,
          description: "Kitty fun tower",
          quantity: 5,
          seller_id: seller.id,
        },
      }
      expect {
        post products_path, params: product_hash
      }.must_change "Product.count", 1

      # check_flash

      new_product = Product.find_by(name: product_hash[:product][:name])
      expect(new_product.name).must_equal product_hash[:product][:name]

      must_respond_with :redirect
      must_redirect_to product_path(new_product.id)
    end

    it "sends a bad_request status if given bad data" do
      product_hash = {
        product: {
          name: " ",
        },
      }
      expect(Product.new(product_hash[:product])).wont_be :valid?

      expect {
        post products_path, params: product_hash
      }.wont_change "Product.count"

      must_respond_with :bad_request

      # check_flash(:warning)
    end
  end
end
