require 'awesome_print'
require 'pry'

MOVE_REGEX = /move (?<number>\d*) from (?<src>\d*) to (?<dst>\d*)/

def parse(input_file)
  lines = File.readlines(input_file, chomp: true)
  split_index = lines.index { |line| line.strip.empty? }

  raw_stacks = lines.slice(0, split_index)
  raw_moves  = lines.slice(split_index+1, lines.length)

  # Parse Stacks
  num_stacks = raw_stacks.pop.split.length
  stacks = Array.new(num_stacks).map { [] }

  raw_stacks.reverse.each do |stack_row|
    stacks.each_with_index do |stack, index|
      item = stack_row[1 + (index * 4)]

      stacks[index] << item if !item.nil? && !item.strip.empty?
    end
  end

  # Parse Moves
  moves = raw_moves.map do |raw_move|
    md = raw_move.match(MOVE_REGEX)

    [
      md[:number].to_i,
      md[:src].to_i - 1,
      md[:dst].to_i - 1
    ]
  end

  [stacks, moves]
end

def day_05_pt1(input_file)
  stacks,moves = parse(input_file)

  moves.each do |move|
    (num, src, dst) = move

    num.times do
      item = stacks[src].pop
      stacks[dst].push item
    end
  end

  ans = stacks.map(&:pop).join
  puts "Answer for Day 5 Pt1 : #{ans}"
end


def day_05_pt2(input_file)
  stacks,moves = parse(input_file)

  moves.each do |move|
    (num, src, dst) = move

    items = stacks[src].pop(num)
    stacks[dst].concat(items)
  end

  ans = stacks.map(&:pop).join
  puts "Answer for Day 5 Pt1 : #{ans}"
end

day_05_pt1("sample.txt")
day_05_pt1("input.txt")
puts
day_05_pt2("sample.txt")
day_05_pt2("input.txt")
