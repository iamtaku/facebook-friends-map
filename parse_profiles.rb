require 'nokogiri'
require_relative 'helpers/search_living'
require_relative 'helpers/make_profile'

puts "Scanning #{Dir['db/profiles/*'].length} files \n ... \n"

Dir.glob('db/profiles/*.html') do |file|
  # puts "checking ... #{file}"
  html_file = open(file).read
  html_doc = Nokogiri::HTML(html_file)
  # puts html_doc.search('title').text
  # root = html_doc.search('.bi.bj')
  profile = make_profile(html_doc)
  puts profile
end

