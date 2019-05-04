require "test_helper"

describe "SellersController" do
  let (:seller) { sellers.first }
  let (:last_seller) { sellers.last }
  describe "logged in seller" do
    describe "show" do
      before do
        perform_login(seller)
      end
      it "Can get a seller with a valid current seller id" do
        perform_login(seller)
        get seller_path(seller)

        must_respond_with :success
      end

      it "Will redirect if given an invalid seller ID" do
        perform_login(seller)
        get seller_path(-1)

        must_respond_with :redirect
      end

      it "Will redirect if given a seller id other than current_seller id" do
        perform_login(seller)
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

    # it "requires login for delete" do
    #   expect {
    #     delete logout_path(Seller.first)
    #   }.wont_change "Seller.count"
    #   must_redirect_to products_path
    # end
  end
end
