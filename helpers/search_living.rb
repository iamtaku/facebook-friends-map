require 'nokogiri'

# file = '/Users/takuheimizutani/code/iamtaku/facebook-friends-map/db/profiles/100000090896803.html'
file = '/Users/takuheimizutani/code/iamtaku/facebook-friends-map/db/profiles/100000187815559.html'

html_file = open(file).read
html_doc = Nokogiri::HTML(html_file)
root = html_doc.search('.bi.bj')

def search_living(root)
  # living = {}
  root_living = root.search('#living')
  # puts root_living
  city = root_living.css('table .ec')
  puts city
  # puts city[0].content
  cities = city.map{ |c| c.content.nil? ? '' : c.content }
  puts cities
  # homeTown = root_living.css('.')
    living = {
      currentCity: cities[0],
      homeTown: cities[1],
    }

    puts living
end

search_living(root)
