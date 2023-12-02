require './challenges/day.rb'

year = ARGV[0]
day = ARGV[1]
input_file = ARGV[2]

puts "Running AOC Challenge #{year} #{day}"

require "./challenges/#{year}/#{day}/#{day}.rb"

Day02.new(input_file)
