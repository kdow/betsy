require 'faker'

100.times do
  Product.create(
    name: Faker::Commerce.product_name 
    price: Faker::Commerce.price 
    seller_id: Faker::Number.number(3)
    description: Faker::Lorem.words(4)
  )
end
