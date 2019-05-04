require "test_helper"

describe CategoriesController do
  describe "index" do
    it "should get index" do
      get categories_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "should get show" do
      get category_path(Category.first.id)

      must_respond_with :success
    end

    it "will respond with 404 if the category is not found" do
      get category_path(-1)

      must_respond_with :not_found
    end
  end
end
