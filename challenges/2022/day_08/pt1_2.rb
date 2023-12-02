require 'awesome_print'
require 'pry'

def parse(input_file)
  File.readlines(input_file, chomp: true).map do |line|
    line.chars.map &:to_i
  end
end

def visible_from?(forest, tree_height, x, y, vx, vy)
  next_x = x+vx
  next_y = y+vy
  next_item = forest.dig(next_y, next_x)

  return true if next_y < 0 || next_x < 0
  return true if next_item.nil?
  return visible_from?(forest, tree_height, next_x, next_y, vx, vy) if tree_height > next_item

  false
end

def day_06_pt1(input_file)
  forest = parse(input_file)
  ans = 0

  forest.each_with_index do |row, y|
    row.each_with_index do |tree_height, x|
      ans += 1 if visible_from?(forest, tree_height, x, y, 0, 1) ||
                  visible_from?(forest, tree_height, x, y, 0, -1) ||
                  visible_from?(forest, tree_height, x, y, 1, 0) ||
                  visible_from?(forest, tree_height, x, y, -1, 0)
    end
  end

  puts "Answer for Day 5 Pt1 : #{ans}"
end

def view_score(forest, tree_height, x, y, vx, vy)
  next_x = x+vx
  next_y = y+vy
  next_item = forest.dig(next_y, next_x)

  return 0 if next_y < 0 || next_x < 0
  return 0 if next_item.nil?
  return 1 + view_score(forest, tree_height, next_x, next_y, vx, vy) if tree_height > next_item 

  1
end

def day_06_pt2(input_file)
  forest = parse(input_file)
  ans = 0

  forest.each_with_index do |row, y|
    row.each_with_index do |tree_height, x|
      score = view_score(forest, tree_height, x, y, 0, 1) *
              view_score(forest, tree_height, x, y, 0, -1) *
              view_score(forest, tree_height, x, y, 1, 0) *
              view_score(forest, tree_height, x, y, -1, 0)

      ans = score if score > ans
    end
  end

  puts "Answer for Day 5 Pt1 : #{ans}"
end

day_06_pt1("sample.txt")
day_06_pt1("input.txt")
puts
day_06_pt2("sample.txt")
day_06_pt2("input.txt")
