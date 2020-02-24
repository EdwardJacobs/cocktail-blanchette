# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

puts "Destroy cocktails"
Cocktail.destroy_all if Rails.env.development?
puts "Destroy doses"
Dose.destroy_all if Rails.env.development?
puts "Destroy ingredients"
Ingredient.destroy_all if Rails.env.development?

doses = ["1oz", "2oz"]

drink_list = ["Gin and Tonic", "Whiskey Sour", "Rum Runner", "Bloody Mary", "Long Island Iced Tea", "Vodka Tonic", "White Russian", "Champagne", "Rum Runner"]

puts "Create ingredients"
url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"

ingredients = JSON.parse(open(url).read)
ingredients["drinks"].each do |ingredient|
  i = Ingredient.create(name: ingredient["strIngredient1"])
  puts "create #{i.name}"
end

9.times do
  puts "Starting created!"
  name = drink_list.sample
  cocktail = Cocktail.create(name: name)
  url = "https://source.unsplash.com/random?cocktail"
  puts "Waiting for unsplash to refresh search"
  sleep(3)
  cocktail.remote_photo_url = url
  cocktail.save

  3.times do
    rand_ingredient = Ingredient.all.sample
    dose_description = doses.sample
    dose = Dose.new( description: dose_description)
    dose.ingredient = rand_ingredient
    dose.cocktail = cocktail
    dose.save
  end
  puts "Drink created!"
end

puts "Seeding finished!"
puts "#{Ingredient.all.count} ingredients added."
puts "#{Dose.all.count} doses added."
puts "#{Cocktail.all.count} drinks added."



