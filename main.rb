require 'awesome_print'
require 'colorize'
require 'pry'

require './challenges/day.rb'

year = ARGV[0]
day = ARGV[1]
input_file = ARGV[2]

require "./challenges/#{year}/#{day}/#{day}.rb"

day_instance = Day02.new(year, day, input_file)

puts "Running AOC Challenge #{year} #{day}"
puts
puts "Answer for AOC Year #{year} #{day} pt1 (#{input_file}) = #{day_instance.pt1}"
puts "Answer for AOC Year #{year} #{day} pt2 (#{input_file}) = #{day_instance.pt2}"
