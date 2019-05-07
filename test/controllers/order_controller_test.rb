require "test_helper"

describe OrderController do
  let (:good_product) { order_products(:one) }
  let (:order) { Order.new }
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

  # describe "update" do
  #   it "can update the order with good data" do
  #     order.assign_attributes(good_data[:order])
  #     expect(order).must_be :valid?
  #     order.reload

  #     patch order_path(order.id), params: good_data

  #     must_respond_with :redirect
  #     #must_redirect_to order_path(order.id)

  #     order.reload
  #     expect(order.status).must_equal "completed"
  #   end
  # end
end
