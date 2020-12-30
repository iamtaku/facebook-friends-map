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
  puts html_doc.search('title')
  root = html_doc.search('.bi.bj')
  root_living = root.search('#living')
  return location unless root_living.any?

  # puts root_living
  lived_in = get_lived_in(root_living)
  puts lived_in
  # 'this was returned'
end

def get_lived_in(root)
  lived_in = []
  home = {}
  city_table = root.search('td')
  city_table[3..-1].each_with_index do |item, index|
    place = {
      year: 'current'
    }
    # item.text = item.text
    puts "TD: #{item.text}"

    break if item.text == 'Hometown'

    if city_table[3..-1][index - 1].text.chars.first(8).join == 'Moved in' && index.positive?
      place[:year] = city_table[3..-1][index - 1].text.chars.slice(9..item.text.length).join.to_i
    end

    next if item.text.chars.first(8).join == 'Moved in'

    place[:name] = item.text
    lived_in << place
  end
  home[:name] = city_table.last.text
  {
    lived_in: lived_in,
    home: home
  }
end

files.each { |file| search_location(file) }
