require "test_helper"

describe Order do
  # let(:order) { Order.new }

  # it "must be valid" do
  #   value(order).must_be :valid?
  # end
  describe "validations" do
    it "has a list of products" do
      order = orders(:one)
      order.must_respond_to :OrderProducts
      order.products.each do |product|
        product.must_be_kind_of OrderProduct
      end
    end
  end
end
