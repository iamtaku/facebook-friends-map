require 'nokogiri'
require 'json'
require_relative 'helpers/search_living'
require_relative 'helpers/make_profile'

puts "Scanning #{Dir['db/profiles/*'].length} files \n ... \n"
sleep 2

# File.open("log.txt", "w") do |f|
  # f.write "#{Time.now} - User logged in\n" end
# open a file
# append contents



json = Dir.glob('db/profiles/*.html').map do |file|
  html_file = open(file).read
  id = file.match(/(\d+)/)[0].to_i
  html_doc = Nokogiri::HTML(html_file)
  profile = make_profile(id, html_doc)
  # puts "parsing #{profile[:name]}..."
  JSON.generate(profile)
end
json_profiles = JSON.generate({key: json})

# p json_profiles
File.write("test.json", json_profiles, mode: "w")

# File.open('test.json','w') do|f|
#   my_hash = JSON.parse(f)
#   puts my_hash
# end

