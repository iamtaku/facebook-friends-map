require 'nokogiri'
require_relative 'helpers/search_living'
require_relative 'helpers/make_profile'

puts "Scanning #{Dir['db/profiles/*'].length} files \n ... \n"
sleep 2

Dir.glob('db/profiles/*.html') do |file|
  html_file = open(file).read
  id = file.match(/(\d+)/)[0].to_i
  html_doc = Nokogiri::HTML(html_file)
  profile = make_profile(id, html_doc)
  puts profile
end

