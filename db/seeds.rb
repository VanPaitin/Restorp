# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
City.create(name: 'Abuja', url_key: 'abuja')
City.create(name: 'Lagos', url_key: 'lagos')
City.create(name: 'Port Harcourt', url_key: 'port-harcourt')

restaurant_columns = Restaurant.column_names
mapped_weekday = { 1 => 'Sunday', 2 => 'Monday', 3 => 'Tuesday', 4 => 'Wednesday', 5 => 'Thursday', 6 => 'Friday', 7 => 'Saturday' }
meal_prices = (950..2150).select do |price|
  price % 50 == 0
end

City.all.each do |city|
  # Get the file_path of the city's restaurants json file
  file_path = "#{Rails.root}/restaurants/#{city.url_key.underscore}_restaurants.json"
  file = File.new(file_path)
  restaurants = JSON.load(file)

  restaurants.each do |restaurant|
    new_restaurant = Restaurant.new
    restaurant_columns.each do |column|
      next if column == 'id'

      if column == 'city_id'
        new_restaurant.city_id = city.id
        next
      end

      if column == 'schedules'
        restaurant['schedules'].each do |schedule|
          week_day_name = mapped_weekday[schedule['weekday']]
          schedule[week_day_name] = {
            'opening_time' => schedule['opening_time'],
            'closing_time' => schedule['closing_time'],
            'opening_type' => schedule['opening_type']
          }
          schedule.slice! week_day_name
        end
      end

      new_restaurant.send("#{column}=", restaurant[column])
    end
    new_restaurant.save

    # Add its cuisines to it without creating duplicate cuisines
    restaurant['cuisines'].each do |cuisine|
      new_restaurant.cuisines << Cuisine.find_or_create_by(name: cuisine['name'], url_key: cuisine['url_key'])
    end
  end

  puts "Completed creation of #{city.name} restaurants"
end

include FactoryBot::Syntax::Methods

Restaurant.includes(:cuisines).each do |restaurant|
  restaurant.cuisines.each do |cuisine|
    create(:meal, price: meal_prices.sample, restaurant: restaurant, cuisine: cuisine)
  end

  puts "Completely creating the meals of Restaurant #{restaurant.name}"
end
