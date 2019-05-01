require "test_helper"

describe ProductsController do
  describe "index" do
    it "can get the index page" do
      get products_path

      must_respond_with :success
    end
  end
end
