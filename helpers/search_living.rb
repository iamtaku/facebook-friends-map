require 'nokogiri'

file = '/Users/takuheimizutani/code/iamtaku/facebook-friends-map/db/profiles/100000090896803.html'

html_file = open(file).read
html_doc = Nokogiri::HTML(html_file)
root = html_doc.search('.bi.bj')

def search_living(root)
  # living = {}
  root_living = root.search('#living')
  city = root_living.css('.ec a')

  # homeTown = root_living.css('.')
  living = {
    currentCity: city[0].content,
    homeTown: city[1].content,
  }
  puts living
end

search_living(root)
