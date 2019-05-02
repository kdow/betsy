require "test_helper"

describe ProductsController do
  let (:seller) {
    Seller.create username: "kittin mittin seller", email: "Kitty@email.com"
  }
  let (:product) {
    Product.create name: "kittin mittins", description: "paw warmers", price: 1200, seller_id: seller.id
  }
  let (:good_data) {
    { product: {
      name: "Catnip",
      price: 600,
      description: "crazy kitty fun time",
      quantity: 10,
      seller_id: seller.id,
    } }
  }
  describe "logged in seller" do
    before do
      @seller = perform_login
    end

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
        get new_seller_product_path(seller.id)

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
          post seller_products_path(seller.id), params: product_hash
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
          post seller_products_path(seller.id), params: product_hash
        }.wont_change "Product.count"

        must_respond_with :bad_request

        # check_flash(:warning)
      end
    end

    describe "Edit" do
      it "can get the edit page for an existing product" do
        get edit_seller_product_path(seller.id, product.id)
        must_respond_with :success
      end

      it "will respond with not found when attempting to edit with a bad product id" do
        get edit_seller_product_path(seller.id, -1)
        must_respond_with :not_found
      end
    end
    describe "update" do
      # let(:product_data) {
      #   {
      #     product: {
      #       name: "Catnip",
      #       price: 600,
      #       description: "crazy kitty fun time",
      #       quantity: 10,
      #       seller_id: seller.id,
      #     },
      #   }
      # }

      it "changes the data on the model" do
        product.assign_attributes(good_data[:product])
        expect(product).must_be :valid?
        product.reload

        patch seller_product_path(seller.id, product), params: good_data

        must_respond_with :redirect
        must_redirect_to product_path(product)

        product.reload
        expect(product.name).must_equal(good_data[:product][:name])
      end
      it "responds with not_found if givin an invalid id" do
        fake_id = -1

        patch seller_product_path(seller.id, fake_id), params: good_data

        must_respond_with :not_found
      end
      it "responds with BAD REQUEST for bad data" do
        good_data[:product][:name] = " "

        product.assign_attributes(good_data[:product])
        expect(product).wont_be :valid?
        product.reload

        patch seller_product_path(seller.id, product), params: good_data

        must_respond_with :bad_request
      end
    end
  end
  describe "Guest user" do
    it "requires login for new" do
      get new_seller_product_path(seller.id)
      must_redirect_to products_path
    end

    it "requires login for create" do
      expect {
        post seller_products_path(seller.id), params: good_data
      }.wont_change "Product.count"

      must_redirect_to products_path
    end

    it "requires login for edit" do
      get edit_seller_product_path(seller.id, Product.first)
      must_redirect_to products_path
    end

    it "requires login for update" do
      first_name = Product.first.name

      patch seller_product_path(seller.id, Product.first), params: good_data

      expect(Product.first.name).must_equal first_name
      must_redirect_to products_path
    end
  end
end
