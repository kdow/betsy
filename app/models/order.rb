class Order < ApplicationRecord
  has_many :order_products, :dependent => :destroy
  has_many :products, through: :order_products
  validates :name, on: :update, presence: true
  validates :email, on: :update, presence: true
  validates :last_four, on: :update, presence: true
  validates :cc_exp, on: :update, presence: true
  # validates :cvv, presence: true
  validates :address, on: :update, presence: true
  validates :city, on: :update, presence: true
  validates :state, on: :update, presence: true
  validates :zip, on: :update, presence: true
  before_save :update_total
  before_create :update_status

  STATES =
    [
      ["AL"],
      ["AK"],
      ["AZ"],
      ["AR"],
      ["CA"],
      ["CO"],
      ["CT"],
      ["DE"],
      ["DC"],
      ["FL"],
      ["GA"],
      ["HI"],
      ["ID"],
      ["IL"],
      ["IN"],
      ["IA"],
      ["KS"],
      ["KY"],
      ["LA"],
      ["ME"],
      ["MD"],
      ["MA"],
      ["MI"],
      ["MN"],
      ["MS"],
      ["MO"],
      ["MT"],
      ["NE"],
      ["NV"],
      ["NH"],
      ["NJ"],
      ["NM"],
      ["NY"],
      ["NC"],
      ["ND"],
      ["OH"],
      ["OK"],
      ["OR"],
      ["PA"],
      ["PR"],
      ["RI"],
      ["SC"],
      ["SD"],
      ["TN"],
      ["TX"],
      ["UT"],
      ["VT"],
      ["VA"],
      ["WA"],
      ["WV"],
      ["WI"],
      ["WY"],
    ]

  def calculate_total
    self.order_products.collect { |item| item.product.price * item.quantity }.sum
  end

  private

  def update_status
    if self.status == nil?
      self.status = "In progress"
    end
  end

  def update_total
    self.total_price = calculate_total
  end
end
