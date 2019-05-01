require 'faker'

20.times do
  Seller.create(
    username: Faker::Name.name,
    email: Faker::Internet.email,
  )
end

20.times do
  Product.create(
    name: Faker::Commerce.product_name,
    price: Faker::Number.between(1, 20),
    seller_id: Faker::Number.between(10, 80),
    description: "Super fun cat product."
  )
end


