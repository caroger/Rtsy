require "open-uri"
require "csv"
require "faker"

User.destroy_all
Product.destroy_all
Review.destroy_all

# Create Users
user_list = [
  [ email: "demo1@rtsy.com", first_name: "League Figure Maker", password: "123456" ],
  [ email: "demo2@rtsy.com", first_name: "League Plush Maker", password: "123456" ],
  [ email: "demo3@rtsy.com", first_name: "League Sculptor", password: "123456" ],
  [ email: "demo4@rtsy.com", first_name: "League Mousepad Maker", password: "123456" ],
  [ email: "demo5@rtsy.com", first_name: "League Hat Maker", password: "123456" ],
  [ email: "demo@rtsy.com", first_name: "Demo User", password: "123456" ]]

user_list.each do |u|
  User.create(u)
end

CSV.foreach(Rails.root.join("lib/seed_csv/product_seeds.csv"), headers: true) do |row|
  p = Product.create({
    name: row["name"],
    category: row["category"],
    seller: User.find_by(first_name: row["seller"]),
    price: row["price"],
    description: row["description"]
  })

  (1..4).each do |n|
    unless row["url#{n}"].to_s.strip.empty?
      file_path = open(row["url#{n}"])
      p.photos.attach(io: file_path, filename: "#{row["name"]}-#{n}.png")
    end
  end
end

(1..10).each do |n|
  user = User.create(
    email: Faker::Internet.email,
    first_name: "#{Faker::Games::LeagueOfLegends.rank} #{Faker::Games::LeagueOfLegends.champion}",
    password: "123456",
    )

  Product.all.each do |product|
    Review.create(product: product,
      reviewer: user,
      rating: rand(2..5),
      body: Faker::Lorem.paragraph(sentence_count: rand(3..6)))
  end
end
