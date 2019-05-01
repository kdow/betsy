require "test_helper"

describe "SellersController" do
  let (:seller) { sellers.first }

  describe "show" do
    it "Can get a product with a valid id" do
      get seller_path(seller.id)

      must_respond_with :success
    end

    it "Will redirect if given an invalid product ID" do
      get seller_path(-1)

      must_respond_with :not_found
    end
  end
end
