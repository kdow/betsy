require "test_helper"

describe "SellersController" do
  let (:seller) { sellers.first }

  describe "show" do
    it "Can get a product with a valid id" do
      perform_login
      get seller_path(seller.id)

      must_respond_with :success
    end

    it "Will redirect if given an invalid product ID" do
      perform_login
      get seller_path(-1)

      must_respond_with :not_found
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
end
