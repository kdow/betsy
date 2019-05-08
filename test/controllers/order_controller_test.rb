require "test_helper"

describe OrderController do
  let (:good_product) { order_products(:one) }
  let (:order) { Order.new }
  let(:order_product) { order_products(:three) }
  let (:good_data) {
    { order: {
      name: "sally",
      email: "sal@gmail.com",
      address: "123 cat road",
      city: "cat city",
      state: "catsilvania",
      zip: "123",
      last_four: "5677",
      cc_exp: "05/25",
      cvv: "567",

    } }
  }
  describe "edit" do
    it "responds with OK for a real order" do
      # order_product_data = {
      #   order_product: {
      #     product_id: 2,
      #     quantity: 1,

      #   },
      # }
      product = Product.first

      post order_products_path, params: {
                                  order_product: {
                                    product_id: product.id,
                                    quantity: 1,
                                  },
                                }
      order = Order.find(session[:order_id])
      get edit_order_path(order.id)
      must_respond_with :ok
    end

    it "responds with NOT FOUND for a fake order" do
      order_id = Order.last.id + 1
      get edit_order_path(order_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "can update the order with good data" do
      product = Product.first

      post order_products_path, params: {
                                  order_product: {
                                    product_id: product.id,
                                    quantity: 1,
                                  },
                                }
      order = Order.find(session[:order_id])

      order.assign_attributes(good_data[:order])
      expect(order).must_be :valid?
      order.reload

      patch order_path(order.id), params: good_data

      must_respond_with :redirect
      must_redirect_to order_path(order.id)

      order.reload
      expect(order.status).must_equal "completed"
    end
    it "must clear the cart after" do
      product = Product.first

      post order_products_path, params: {
                                  order_product: {
                                    product_id: product.id,
                                    quantity: 1,
                                  },
                                }
      order = Order.find(session[:order_id])

      order.assign_attributes(good_data[:order])
      expect(order).must_be :valid?
      order.reload
      patch order_path(order.id), params: good_data

      expect(session[:order_id]).must_equal nil
    end
    it "can't update with bad data" do
      product = products(:crown)
      bad_data = {
        order: {
          name: "sally",
          email: "sal@gmail.com",
          address: "123 cat road",
          city: "cat city",
          state: "catsilvania",
          zip: "123",
          last_four: "5677",
          cc_exp: nil,
          cvv: nil,

        },
      }

      post order_products_path, params: {
                                  order_product: {
                                    product_id: product.id,
                                    quantity: 5,
                                  },
                                }
      order = Order.find(session[:order_id])

      order.assign_attributes(good_data[:order])
      expect(order).must_be :valid?
      order.reload

      patch order_path(order.id), params: bad_data
      must_respond_with :bad_request

      expect(order.valid?).must_equal false
    end
  end
end
