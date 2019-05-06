require "test_helper"

describe "SellersController" do
  let (:seller) { sellers(:sarah) }
  let (:last_seller) { sellers(:kelly) }
  let (:new_seller) { sellers(:devin) }
  describe "logged in seller" do
    before do
      perform_login(seller)
    end
    describe "show" do
      it "Can get a seller with a valid current seller id" do
        get seller_path(seller)

        must_respond_with :success
      end

      it "Will redirect if given an invalid seller ID" do
        get seller_path(-1)

        must_respond_with :redirect
      end

      it "Will redirect if given a seller id other than current_seller id" do
        get seller_path(:last_seller)

        must_respond_with :redirect
      end
    end

    describe "product_index" do
      it "can get to seller products" do
        get seller_products_path(seller.id)

        must_respond_with :success
      end
      it "Will respond with not_found if given an invalid seller ID" do
        get seller_products_path(-1)

        must_respond_with :not_found
      end
    end

    describe "order_product_index" do
      it "can get to seller products" do
        get seller_order_products_path(seller.id)

        must_respond_with :success
      end
      it "Will respond with not_found if given an invalid seller ID" do
        get seller_order_products_path(-1)

        must_respond_with :not_found
      end
    end

    describe "order_show" do
      before do
        @order_id = seller.orders.first.id
      end
      it "can get order_show with valid seller and order id" do
        get seller_order_path(seller.id, @order_id)

        must_respond_with :success
      end

      it "Will respond with not_found if given an invalid seller ID" do
        get seller_order_path(-1, @order_id)

        must_respond_with :not_found
      end

      it "Will respond with redirect if given a order id that the seller does not have" do
        new_seller = sellers(:new_seller)
        get seller_order_path(new_seller.id, @order_id)

        must_respond_with :redirect
      end

      it "will respond with not_found if given a bad order_id" do
        get seller_order_path(seller.id, -1)

        must_respond_with :not_found
      end
    end

    describe "product_categories_edit" do
      before do
        @product = seller.products.first
      end
      it "can get order_show with valid seller and product id" do
        get seller_product_categories_path(seller.id, @product.id)

        must_respond_with :success
      end
      it "Will respond with redirect if given a product id that the seller does not have" do
        other_product = last_seller.products.first
        get seller_product_categories_path(seller.id, other_product.id)

        must_respond_with :redirect
      end
      it "Will respond with not_found if given an invalid seller ID" do
        get seller_product_categories_path(-1, @product.id)

        must_respond_with :not_found
      end
      it "will respond with not_found if given a bad product_id" do
        get seller_product_categories_path(seller.id, -1)

        must_respond_with :not_found
      end
    end

    describe "product_categories_update" do
      let(:product_data) {
        {
          product: {
            category_ids: [categories(:toys).id, categories(:hats).id],
          },
        }
      }
      let(:product) { seller.products.first }
      it "change the data on the model" do
        expect(product.categories.count).must_equal 0

        patch seller_product_categories_path(seller, product), params: product_data

        expect(flash[:success]).wont_be_nil
        must_redirect_to product_path(product)
        expect(product.categories.count).must_equal 2
        expect(product.categories).must_include categories(:toys)
      end

      it "Will respond with redirect if given a product id that the seller does not have" do
        other_product = last_seller.products.first
        patch seller_product_categories_path(seller.id, other_product.id), params: product_data

        must_respond_with :redirect
      end
      it "Will respond with not_found if given an invalid seller ID" do
        patch seller_product_categories_path(-1, product.id), params: product_data

        must_respond_with :not_found
      end
    end

    describe "destroy" do
      ### TODO
    end
  end

  describe "auth_callback" do
    it "logs in an existing seller and redirects to the root route" do
      start_count = Seller.count
      seller = sellers(:sarah)

      perform_login(seller)
      must_redirect_to root_path
      session[:seller_id].must_equal seller.id
      Seller.count.must_equal start_count
    end

    it "creates a new seller and redirects to the root route" do
      start_count = Seller.count
      seller = Seller.new(provider: "github", uid: 99999, username: "test_seller", email: "test@seller.com")

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(seller))

      seller.save

      get auth_callback_path(:github)

      must_redirect_to root_path

      Seller.count.must_equal start_count + 1

      session[:seller_id].must_equal Seller.last.id
    end

    it "redirects to the login route if given invalid seller data" do
      start_count = Seller.count
      seller = Seller.new()

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(seller))

      seller.save

      get auth_callback_path(:github)

      must_redirect_to root_path

      Seller.count.must_equal start_count

      session[:seller_id].must_be_nil
    end
  end
  describe "Guest user" do
    it "requires login for show" do
      get seller_path(Seller.first)
      must_redirect_to products_path
    end

    it "requires login for product_index" do
      get seller_products_path(seller.id)
      must_redirect_to products_path
    end
    it "requires login for order_product_index" do
      get seller_order_products_path(seller.id)
      must_redirect_to products_path
    end
    it "requires login for order_show" do
      get seller_order_path(seller.id, seller.orders.first)
      must_redirect_to products_path
    end

    # it "requires login for delete" do
    #   expect {
    #     delete logout_path(Seller.first)
    #   }.wont_change "Seller.count"
    #   must_redirect_to products_path
    # end

  end
end
