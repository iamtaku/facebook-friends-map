require 'json'

file = File.open "test.json"
data = JSON.load file

puts data['key']
