require 'nokogiri'
bad = []
puts "Scanning #{Dir['db/profiles/*'].length} files \n ... \n"

Dir.glob('db/profiles/*.html') do |file|
  # puts "checking ... #{file}"
  html_file = open(file).read
  html_doc = Nokogiri::HTML(html_file)
  # puts html_doc.search('.u.v.w').attribute('placeholder').content[0]
  if html_doc.search('.u.v.w').attribute('placeholder').nil? || html_doc.search('.u.v.w').attribute('placeholder').content[0] != 'S'
    bad << Dir.pwd + '/' + file
  end
end

if bad.empty?
  puts 'No bad files👼'
  exit
end

puts "There are #{bad.count} files that are bad😩"

puts "Deleting bad files...🗑 \n"
bad.each do |file|
  puts "Deleting : #{file}"
  File.delete(file) if File.exist?(file)
end
