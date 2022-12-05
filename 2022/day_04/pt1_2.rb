require 'awesome_print'
require 'pry'

def parse(input_file)
  pairs = File.read(input_file).lines.map do |line|
    line.split(',').map do |part|
      part.split('-').map &:to_i
    end
  end
end

def day_04_pt1(input_file)
  pairs = parse(input_file)

  score = 0
  pairs.each do |pair|
    if ( pair[0][0] >= pair[1][0] && pair[0][1] <= pair[1][1] ) || ( pair[0][0] <= pair[1][0] && pair[0][1] >= pair[1][1] )
      score += 1
    end
  end

  puts "Score for Day 4 Pt1 : #{score}"
end


def day_04_pt2(input_file)
  pairs = parse(input_file)

  score = 0
  pairs.each do |pair|
    if pair[1][0] <= pair[0][1] && pair[0][0] <= pair[1][1]
      score += 1
    end
  end

  puts "Score for Day 4 Pt1 : #{score}"
end

day_04_pt1("sample.txt")
day_04_pt1("input.txt")
puts
day_04_pt2("sample.txt")
day_04_pt2("input.txt")
