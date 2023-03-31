require "json"
require "open-uri"

# Ask the user for their location.
puts "Where is your location?"

# Get and store the user's location.
user_location = gets.chomp

# Get the user's latitude and longitude from the Google Maps API.
gmaps_key = ENV.fetch("GMAPS_KEY")

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{gmaps_key}"

raw_gmaps_data = URI.open(gmaps_url).read

parsed_gmaps = JSON.parse(raw_gmaps_data)

location = parsed_gmaps.fetch("results").at(0).fetch("geometry").fetch("location")

lat = location.fetch("lat")
lng = location.fetch("lng")
p lat
p lng

# Get the weather at the user's coordinates from the Dark Sky API.
pirate_weather_key = ENV.fetch("PIRATE_WEATHER_KEY")

pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_key}/#{lat},#{lng}"

raw_weather_data = URI.open(pirate_weather_url).read
parsed_weather = JSON.parse(raw_weather_data)

current_weather = parsed_weather.fetch("currently").fetch("summary")

current_temp = parsed_weather.fetch("currently").fetch("temperature")


# Display the current temperature and summary of the weather for the next hour.
puts "It is currently #{current_temp}°F and #{current_weather.downcase} in #{user_location.capitalize}."


# For each of the next twelve hours, check if the precipitation probability is greater than 10%.
    # If so, print a message saying how many hours from now and what the precipitation probability is.
# If any of the next twelve hours has a precipitation probability greater than 10%, print "You might want to carry an umbrella!"

# If not, print "You probably won't need an umbrella today."
