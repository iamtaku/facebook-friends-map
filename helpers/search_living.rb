require 'nokogiri'
require 'pry'

file1 = '/Users/takuheimizutani/code/iamtaku/facebook-friends-map/db/profiles/100000090896803.html'
file2 = '/Users/takuheimizutani/code/iamtaku/facebook-friends-map/db/profiles/100000187815559.html'
file3 = '/Users/takuheimizutani/code/iamtaku/facebook-friends-map/db/profiles/100000126333972.html'
files = [file1, file2, file3]

# html_file = open(file).read
# html_doc = Nokogiri::HTML(html_file)
# root = html_doc.search('.bi.bj')

def search_location(root_file)
  location = {
    lived_in: nil,
    home: nil
  }
  html_file = open(root_file).read
  html_doc = Nokogiri::HTML(html_file)
  root = html_doc.search('.bi.bj')
  root_living = root.search('#living')
  return location unless root_living.any?

  location = get_location(root_living)
end

def get_location(root)
  # lived_in = []
  home = {}
  city_table = root.search('td')
  lived_in = create_lived_in(city_table)
  home[:name] = city_table.last.text
  {
    lived_in: lived_in,
    home: home
  }
  # return location hash
  # need lived_in
end

def create_lived_in(city_table)
  lived_in = []
  city_table[3..].each_with_index do |item, index|
    break if item.text == 'Hometown'
    # check if each <td> has a year attached and attach to place object if attached

    next if item.text.chars.first(8).join == 'Moved in'

    lived_in << {
      name: item.text,
      year: get_year(city_table, index)
    }
  end
  lived_in
end

def get_year(city_table, index)
  year = nil
  if index.positive? && city_table[3..][index - 1].text.chars.first(8).join == 'Moved in'
    year = city_table[3..][index - 1].text.match(/\d{4}/)[0].to_i
  end
  year
end

location = files.map { |file| search_location(file) }
p location

