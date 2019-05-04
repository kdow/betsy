require "test_helper"

describe OrderProductsController do

  it "refuses order if quantity greater than inventory" do

    order_product_data = {
      order_product: {
        quantity: 10000,
        product_id: Product.first.id,
      }
    }

    test_item = OrderProduct.new(order_product_data[:order_product])
    before_inventory = test_item.quantity
    
    post order_products_path(order_product_data)

    expect {
      post order_products_path, params: order_product_data
    }.wont_change('Order.count')

    expect(test_item.quantity).must_equal before_inventory
    
  end
end
