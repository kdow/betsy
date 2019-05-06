require "test_helper"

describe OrderProductsController do
  describe "create" do
    it "should get created" do
      proc {
        post order_products_path,
             params: {
               order_product: {
                 quantity: 4,
                 product_id: Product.first.id,
               },
             }
      }.must_change "OrderProduct.count", 1
      must_respond_with :redirect
      must_redirect_to products_path
    end
  end

  it "refuses order if quantity greater than inventory" do
    order_product_data = {
      order_product: {
        quantity: 10000,
        product_id: Product.first.id,
      },
    }

    test_item = OrderProduct.new(order_product_data[:order_product])
    before_inventory = test_item.quantity

    post order_products_path(order_product_data)

    expect {
      post order_products_path, params: order_product_data
    }.wont_change("Order.count")

    expect(test_item.quantity).must_equal before_inventory
  end

  it "updates quantity in the cart" do
    skip
    proc {
      patch order_product_path(order_products(:one).quantity),
            params: {
              order_product: {
                quantity: 4,
                product_id: Product.first.id,
              },
            }
    }.must_change "OrderProduct.quantity", +1
    must_respond_with :redirect
    must_redirect_to order_product_path
  end
end
