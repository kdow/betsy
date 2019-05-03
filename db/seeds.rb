require "faker"

20.times do
  Seller.create(
    username: Faker::Name.name,
    email: Faker::Internet.email,
  )
end

category_list = [
  Category.create(name: "accessories"),
  Category.create(name: "toys"),
  Category.create(name: "plants"),
  Category.create(name: "food"),
]

20.times do
  product = Product.create(
    name: Faker::Commerce.product_name,
    price: Faker::Number.between(1, 20),
    seller_id: Faker::Number.between(1, 20),
    description: "Super fun cat product.",
  )
  product.categories << category_list.sample
  product.save
end
