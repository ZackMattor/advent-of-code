require 'awesome_print'
require 'pry'

def item_to_value(item)
  val = item.ord
  val < 96 ? ( val - 38 ) : ( val - 96 )
end

def day_03_pt1(input_file)
  bags_by_component = File.read(input_file).lines.map { |item| item.chomp.chars.each_slice((item.length/2).round).to_a}

  same_items_per_bag_by_value = bags_by_component.map do |bag|
    (bag.first & bag.last).map { |item| [ item_to_value(item) ] }
  end

  sum_of_shared_item_values = same_items_per_bag_by_value.flatten.sum
  puts "Answer for input #{input_file} for Day2 Pt1 : #{ sum_of_shared_item_values }"
end


def day_03_pt2(input_file)
  bags_by_item = File.read(input_file).lines.map { |item| item.chomp.chars }
  bags_by_item_and_group = bags_by_item.group_by.with_index { |bag, elf_index| elf_index / 3 }

  badges_by_value = bags_by_item_and_group.map do |k, group|
    (group[0] & group[1] & group[2]).map { |item| [ item_to_value(item) ] }
  end

  sum_of_badge_values = badges_by_value.flatten.sum
  puts "Answer for input #{input_file} for Day2 Pt1 : #{ sum_of_badge_values }"
end

day_03_pt1("sample.txt")
day_03_pt1("input.txt")
puts
day_03_pt2("sample.txt")
day_03_pt2("input.txt")
