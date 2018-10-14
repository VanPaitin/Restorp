# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

class RestaurantSeed
  include FactoryBot::Syntax::Methods

  def create_cities
    City.create(name: 'Abuja', url_key: 'abuja')
    City.create(name: 'Lagos', url_key: 'lagos')
    City.create(name: 'Port Harcourt', url_key: 'port-harcourt')
    puts "Created cities"
  end

  def create_restaurants
    restaurant_columns = Restaurant.column_names - %w(id city_id)

    City.all.each do |city|
      restaurants = get_restaurants(city)

      restaurants.each do |restaurant|
        new_restaurant = Restaurant.new(city_id: city.id)

        restaurant_columns.each do |column|
          format_schedules(restaurant) if column == 'schedules'
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
  end

  def create_meals
    Restaurant.includes(:cuisines).each do |restaurant|
      restaurant.cuisines.each do |cuisine| # Create one meal per cuisine
        create(:meal, price: meal_prices.sample, restaurant: restaurant, cuisine: cuisine)
      end

      puts "Completely created the meals of Restaurant #{restaurant.name}"
    end
  end

  private

  def format_schedules(restaurant)
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

  def meal_prices
    prices = []
    (950..2150).step(50) do |price|
      prices << price
    end
    prices
  end

  def mapped_weekday
    { 1 => 'Sunday', 2 => 'Monday', 3 => 'Tuesday', 4 => 'Wednesday', 5 => 'Thursday', 6 => 'Friday', 7 => 'Saturday' }
  end

  def get_restaurants(city)
    file_path = "#{Rails.root}/restaurants/#{city.url_key.underscore}_restaurants.json"
    file = File.new(file_path)
    JSON.load(file)
  end
end

seeder = RestaurantSeed.new

seeder.create_cities
seeder.create_restaurants
seeder.create_meals
