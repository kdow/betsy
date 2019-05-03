require "faker"

20.times do
  Seller.create(
    username: Faker::Name.name,
    email: Faker::Internet.email,
  )
end

accessories = Category.create(name: "accessories")
toys = Category.create(name: "toys")
food = Category.create(name: "food")
baskets = Category.create(name: "baskets")

puff = Product.create(
  name: "Puff ball on a string",
  price: 800,
  seller_id: Faker::Number.between(1, 20),
  description: "Your cat will love playing with this fluffy puff ball.",
  photo_url: "https://live.staticflickr.com/65535/47745224121_36f9a5ce73_q.jpg",
)

puff.categories << toys
puff.save

bowtie = Product.create(
  name: "Starry bowtie",
  price: 1200,
  seller_id: Faker::Number.between(1, 20),
  description: "Your cat will be the hit of the holiday party with this classy red starred bowtie.",
  photo_url: "https://live.staticflickr.com/65535/46828525745_35d4075877_q.jpg",
)

bowtie.categories << accessories
bowtie.save

cupcake = Product.create(
  name: "Birthday cupcake",
  price: 600,
  seller_id: Faker::Number.between(1, 20),
  description: "Celebrate your cat's birthday with this delicious cupcake.",
  photo_url: "https://live.staticflickr.com/65535/40778594773_29b2ae56fe_q.jpg",
)

cupcake.categories << food
cupcake.save

crown = Product.create(
  name: "Royal crown",
  price: 4000,
  seller_id: Faker::Number.between(1, 20),
  description: "Treat your cat like royalty with this golden crown.",
  photo_url: "https://live.staticflickr.com/65535/46955779884_e13401bd56_q.jpg",
)

crown.categories << accessories
crown.save

basket = Product.create(
  name: "Brown basket",
  price: 2000,
  seller_id: Faker::Number.between(1, 20),
  description: "Transport your kittens with this handcrafted brown basket.",
  photo_url: "https://live.staticflickr.com/65535/47745224261_c5751b775d_q.jpg",
)

basket.categories << baskets
basket.save

garland = Product.create(
  name: "Garland",
  price: 2600,
  seller_id: Faker::Number.between(1, 20),
  description: "This garland is made from four different types of flowers",
  photo_url: "https://live.staticflickr.com/65535/46955780024_c77fce1ffa_q.jpg",
)

garland.categories << accessories
garland.save

tree = Product.create(
  name: "Cat tree",
  price: 3999,
  seller_id: Faker::Number.between(1, 20),
  description: "This cat tree has four different platforms for your cat to lounge on.",
  photo_url: "https://live.staticflickr.com/65535/46828525885_376f0403f6_q.jpg",
)

tree.categories << accessories
tree.save

neckerchief = Product.create(
  name: "Neckerchief",
  price: 750,
  seller_id: Faker::Number.between(1, 20),
  description: "Add some flair to your cat with this jaunty neckerchief.",
  photo_url: "https://live.staticflickr.com/65535/40778594993_2aa1379e0a_q.jpg",
)

neckerchief.categories << accessories
neckerchief.save

strmousie = Product.create(
  name: "Mousie on a string",
  price: 499,
  seller_id: Faker::Number.between(1, 20),
  description: "Keep your cat entertained with this mousie on a string.",
  photo_url: "https://live.staticflickr.com/65535/47745224481_3a615be75c_q.jpg",
)

strmousie.categories << toys
strmousie.save

balloon = Product.create(
  name: "Balloon",
  price: 199,
  seller_id: Faker::Number.between(1, 20),
  description: "Pink balloon",
  photo_url: "https://live.staticflickr.com/65535/40778595283_42c2520070_q.jpg",
)

balloon.categories << toys
balloon.save

cone = Product.create(
  name: "Party hat",
  price: 1000,
  seller_id: Faker::Number.between(1, 20),
  description: "Cone shaped, red striped, party hat, purrfect for any occasion.",
  photo_url: "https://live.staticflickr.com/65535/47745224621_02094e3287_q.jpg",
)

cone.categories << accessories
cone.save

treat = Product.create(
  name: "Treats",
  price: 500,
  seller_id: Faker::Number.between(1, 20),
  description: "Tasty treats for your special feline.",
  photo_url: "https://live.staticflickr.com/65535/46828526275_b3b7d00a46_q.jpg",
)

treat.categories << food
treat.save

oats = Product.create(
  name: "Oats",
  price: 350,
  seller_id: Faker::Number.between(1, 20),
  description: "Treat your cat to some delicious overnight oats",
  photo_url: "https://live.staticflickr.com/65535/47745224771_7ac0f37b01_q.jpg",
)

oats.categories << food
oats.save

clown = Product.create(
  name: "Clown",
  price: 1999,
  seller_id: Faker::Number.between(1, 20),
  description: "Send in the clowns for your fun-loving feline",
  photo_url: "https://live.staticflickr.com/65535/47745224801_e3dc98fcc5_q.jpg",
)

clown.categories << toys
clown.save

pink = Product.create(
  name: "Toy on a string",
  price: 299,
  seller_id: Faker::Number.between(1, 20),
  description: "Give your cat some exercise with this fluffy pink string toy.",
  photo_url: "https://live.staticflickr.com/65535/40778595443_e71a75d680_q.jpg",
)

pink.categories << toys
pink.save

ornament = Product.create(
  name: "Ornamanet",
  price: 899,
  seller_id: Faker::Number.between(1, 20),
  description: "Set of 4 golden ornaments adorned with red snowflakes.",
  photo_url: "https://live.staticflickr.com/65535/46955780684_258c532e6e_q.jpg",
)

ornament.categories << toys
ornament.save

mousie = Product.create(
  name: "Mousie",
  price: 150,
  seller_id: Faker::Number.between(1, 20),
  description: "Your cat will love playing with this gray felt mousie.",
  photo_url: "https://live.staticflickr.com/65535/47697876262_57db4c5058_q.jpg",
)

mousie.categories << toys
mousie.save

blackbasket = Product.create(
  name: "Black and white basket",
  price: 1000,
  seller_id: Faker::Number.between(1, 20),
  description: "Beautiful black and white basket, suitable for one kitten.",
  photo_url: "https://live.staticflickr.com/65535/46833977585_725e2822b3_q.jpg",
)

blackbasket.categories << baskets
blackbasket.save

orangebasket = Product.create(
  name: "Bike basket",
  price: 2000,
  seller_id: Faker::Number.between(1, 20),
  description: "Sturdy orange basket for your cat to accompany you on bike rides.",
  photo_url: "https://live.staticflickr.com/65535/46833978835_ac32b0a243_q.jpg",
)

orangebasket.categories << baskets
orangebasket.save

kittenbasket = Product.create(
  name: "Kitten basket",
  price: 2999,
  seller_id: Faker::Number.between(1, 20),
  description: "Lovely rustic basket will hold a litter of kittens.",
  photo_url: "https://live.staticflickr.com/65535/46833981635_ae0bdc4c5b_q.jpg",
)

kittenbasket.categories << baskets
kittenbasket.save

flowers = Product.create(
  name: "Bouquet of flowers",
  price: 1499,
  seller_id: Faker::Number.between(1, 20),
  description: "Every cat deserves a bouquet of flowers.",
  photo_url: "https://live.staticflickr.com/65535/32807149837_443ae0dba0_q.jpg",
)

flowers.categories << accessories
flowers.save
