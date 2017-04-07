require "json"
json = File.read("data/Test_rpgtable.json")
obj = JSON.parse(json)

puts obj.to_s
name = obj['name']
puts name.to_s
table = obj['table']
puts table.to_s
