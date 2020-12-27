require 'nokogiri'

puts 'enter a url to scrape...'
url = gets.chomp
# url = 'db/profiles/6859201.html'
html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)
# puts html_doc
profile = {}

puts root = html_doc.search('.bi.bj')
puts work = root.search('#work')
puts education = root.search('#education')
puts living = root.search('#living')
puts family = root.search('#family')
puts basic_info = root.search('#basic-info')
puts year_overviews = root.search('#year-overviews')

# html_doc.search('.de.df.dg.dh.di').each do |element|
#   puts element
#   element.css('.do').each do |item|
#     # profile[:item.content] =
#     # puts item

#   end

# end
# html_doc.search('.dd')[2].css('a').each { |item| puts item.content }
# # puts html_doc.css('.dd a')
# html_doc.search('.dd').each do |element|
#   puts element
#   element.css('a').each { |item| puts item.content }
# end

