require 'nokogiri'

def search_location(root_file)
  location = {
    lived_in: nil,
    home: nil
  }
  html_file = open(root_file).read
  html_doc = Nokogiri::HTML(html_file)
  root = html_doc.search('.bi.bj')
  root_living = root.search('#living')
  return location unless root_living.any? # return blank hash if empty

  create_location(root_living) # call function to create location hash otherwise
end

def create_location(root_living)
  city_table = root_living.search('td')
  {
    lived_in: create_lived_in(city_table), # call create_lived_in function to generate array of places lived
    home: {
      name: city_table.last.text
    }
  }
end

def create_lived_in(city_table)
  lived_in = []
  # check if each <td> in city_table has a year attached and attach to place object if attached
  city_table[3..].each_with_index do |item, index|
    break if item.text == 'Hometown'

    next if item.text.chars.first(6).join == 'Moved ' # if item begins with 'Moved ', will skip

    lived_in << {
      name: item.text,
      year: get_year(city_table, index)
    }
  end
  lived_in
end

def get_year(city_table, index)
  year = nil
  # check if previous item is a 'Moved in ...' format and if so, add year property to current item that is iterated
  if index.positive? && city_table[3..][index - 1].text.chars.first(8).join == 'Moved in'
    year = city_table[3..][index - 1].text.match(/\d{4}/)[0].to_i
  end
  year
end

# location = files.map { |file| p search_location(file) }
# p location
Dir.glob('db/profiles/*.html') do |file|
  # puts "checking ... #{file}"
  p file
  p search_location(file)

  # puts html_doc.search('.u.v.w').attribute('placeholder').content[0]
  # if html_doc.search('.u.v.w').attribute('placeholder').nil? || html_doc.search('.u.v.w').attribute('placeholder').content[0] != 'S'
  #   bad << Dir.pwd + '/' + file
  # end
  # puts file
end
