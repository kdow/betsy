require "test_helper"

describe CategoriesController do
  describe "logged in seller" do
    before do
      perform_login
    end
    describe "new" do
      it "can get the new work page" do
        get new_category_path

        must_respond_with :success
      end
    end

    describe "create" do
      it "should create new categories" do
        category_hash = {
          category: {
            name: "Clothing",
          },
        }
        expect {
          post categories_path, params: category_hash
        }.must_change "Category.count", 1

        must_respond_with :redirect
      end

      it "should respond with bad request if the category is missing a name" do
        category_hash = {
          category: {
            name: "",
          },
        }
        expect {
          post categories_path, params: category_hash
        }.wont_change "Category.count"

        must_respond_with :bad_request
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
    describe "brows category" do
      it "can show the selected category" do
        @category = Category.last
        get category_path(@category.id)

        must_respond_with :success
      end
 
    end
  end
  describe "Guest user" do
    describe "index" do
      it "should get index" do
        get categories_path
        must_respond_with :success
      end
    end

    describe "new" do
      it "will redirect when not logged in" do
        get new_category_path

        must_redirect_to products_path
      end
    end

    describe "create" do
      it "will redirect when not logged in" do
        category_hash = {
          category: {
            name: "Clothing",
          },
        }
        expect {
          post categories_path, params: category_hash
        }.wont_change "Category.count"

        must_redirect_to products_path
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
end
