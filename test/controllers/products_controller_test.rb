require "test_helper"

describe ProductsController do
  let (:product) {
    Product.create name: "kittin mittins", description: "paw warmers", price: 1200
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
end
