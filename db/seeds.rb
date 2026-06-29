User.destroy_all

10.times do
  User.create!(
    email: Faker::Internet.email,
    password: 'password'
  )
end

User.find_each do |user|
  3.times do
    Ingredient.create!(
      name: Faker::Name.name,
      user: user
    )
  end
end

Ingredient.find_each do |ingredient|
  3.times do
    IngredientStock.create!(
      expire_on: Faker::Date.between(from: Date.current, to: 1.month.from_now),
      quantity: Faker::Number.number(digits: 1),
      ingredient: ingredient
    )
  end
end
