require "test_helper"

describe CartsController do
  describe "show" do
    it "should get show" do
      get cart_path(@order)
      assert_response :success
    end
  end
end
