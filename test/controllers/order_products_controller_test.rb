require "test_helper"

describe OrderProductsController do

  describe "create" do
    it "should get created" do
      order_product_data = {
        product_id: Product.first.id,
        order_id: Order.first.id,
        quantity: 1
      }
       
      before_count = OrderProduct.count

      OrderProduct.new(order_product_data).must_be :valid?

      post order_products_path, params: {order_product: order_product_data}

      must_respond_with :redirect

      OrderProduct.count.must_equal before_count + 1
    end
  end

  describe 'update' do

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
      product_one = Product.first
      order_product_data = {
        product_id: product_one.id,
        quantity: 2
      }
      before_count = OrderProduct.count

      post order_products_path, params: { order_product: order_product_data }
      OrderProduct.count.must_equal before_count + 1

    end

    it 'does not update a product with invalid data' do
      order_product = {
        product_id: Product.first.id,
        order_id: Order.first.id,
        quantity: 1
      }
      post order_products_path, params: {order_product: order_product}

      test_product = OrderProduct.last

      test_product.assign_attributes(quantity: 0)
      test_product.wont_be :valid?

      patch order_product_path(test_product.id), params: { order_product: {quantity: 0} }

      must_redirect_to cart_path
      test_product.reload
      test_product.quantity.must_equal 1
    end
  end

  describe 'destroy' do
    
    before do
      product = Product.first
      post order_products_path, params: {
        order_product: {
          product_id: product.id,
          quantity: 1
        }
      }

      @order_id = Order.last.id
      @order_product_id = OrderProduct.last.id
      @before_count = OrderProduct.find_by(id: @order_product_id).quantity
    end

    it "removes the item from the current cart" do
  
      expect {
        delete order_product_path(@order_product_id)
      }.must_change "OrderProduct.count", -1

      must_respond_with :redirect
      must_redirect_to cart_path
      expect (OrderProduct.find_by(id: @order_product_id)).must_be_nil
    end
  end
end
