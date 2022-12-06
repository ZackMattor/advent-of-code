require 'awesome_print'
require 'pry'

def parse(input_file)
  lines = File.readlines(input_file, chomp: true).first.chars
  lines
end

def day_06_pt1(input_file)
  data = parse(input_file)
  index = 0
  buffer = []

  data.each do |item|
    buffer << item 
    index += 1

    if buffer.length == 4
      break if !buffer.group_by(&:itself).any? { |k, v| v.size > 1 }
      buffer.shift
    end
  end

  puts "Answer for Day 5 Pt1 : #{index}"
end


def day_06_pt2(input_file)
  data = parse(input_file)
  index = 0
  buffer = []

  data.each do |item|
    buffer << item 
    index += 1

    if buffer.length == 14
      break if !buffer.group_by(&:itself).any? { |k, v| v.size > 1 }
      buffer.shift
    end
  end

  puts "Answer for Day 5 Pt1 : #{index}"
end

day_06_pt1("sample.txt")
day_06_pt1("input.txt")
puts
day_06_pt2("sample.txt")
day_06_pt2("input.txt")
