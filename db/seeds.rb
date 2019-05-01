require 'faker'

20.times do
  Seller.create(
    username: Faker::Name.name,
    email: Faker::Internet.email,
  )
end

100.times do
  Product.create(
    name: Faker::Commerce.product_name,
    price: Faker::Commerce.price, 
    seller_id: Faker::Number.between(1, 20),
    description: Faker::Lorem.words(4)
  )
end


