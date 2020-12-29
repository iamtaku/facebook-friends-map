require 'nokogiri'

file1 = '/Users/takuheimizutani/code/iamtaku/facebook-friends-map/db/profiles/100000090896803.html'
file2 = '/Users/takuheimizutani/code/iamtaku/facebook-friends-map/db/profiles/100000187815559.html'
file3 = '/Users/takuheimizutani/code/iamtaku/facebook-friends-map/db/profiles/100000126333972.html'
files = [file1, file2, file3]

# html_file = open(file).read
# html_doc = Nokogiri::HTML(html_file)
# root = html_doc.search('.bi.bj')

def search_living(root_file)
  living = {
    currentCity: '',
    homeTown: ''
  }
  html_file = open(root_file).read
  html_doc = Nokogiri::HTML(html_file)
  puts html_doc.search('title')
  root = html_doc.search('.bi.bj')
  root_living = root.search('#living')
  city_table = root_living.css('tr')
  city_table.each { |item| puts item.nil? }
  cities = city_table.map { |c| c.content.nil? ? '' : c.content }
  # puts cities
  living = {
    currentCity: cities[0],
    homeTown: cities[1],
  }
end


files.each {|file| search_living(file)}
# search_living(root)
