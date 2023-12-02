require 'pry'
require 'awesome_print'

class Monkey
  attr_accessor :id, :items, :operation, :test, :true_monkey_id, :false_monkey_id
  attr_accessor :true_monkey, :false_monkey, :items_inspected, :lcm, :stressed

  def self.read_file_create_monkeys(input_file, stressed = false)
    lines = File.readlines(input_file, chomp: true)
    monkeys = []

    while line = lines.shift
      if id = line.match(/Monkey (\d+):/)
        monkey = new

        monkey.id = id[1]
        monkey.items = lines.shift.match(/Starting items: (.*)/)[1].split(', ').map(&:to_i).reverse
        monkey.operation = lines.shift.match(/new = old (.*)/)[1].split
        monkey.test = lines.shift.match(/divisible by (\d*)/)[1].to_i
        monkey.true_monkey_id = lines.shift.match(/throw to monkey (\d*)/)[1].to_i
        monkey.false_monkey_id = lines.shift.match(/throw to monkey (\d*)/)[1].to_i
        monkey.stressed = stressed

        monkeys << monkey
      end
    end


    lcm = monkeys.map(&:test).inject &:*
    monkeys.each do |monkey|
      monkey.lcm = lcm
      monkey.true_monkey = monkeys[monkey.true_monkey_id]
      monkey.false_monkey = monkeys[monkey.false_monkey_id]
    end

    monkeys
  end

  def initialize
    @items_inspected = 0
  end

  def take_turn!
    while item = @items.pop
      inspect_item!(item)
      @items_inspected += 1
    end
  end

  def inspect_item!(item)
    if @operation.last == 'old'
      item = item * item
    else
      item = item.send(@operation.first.to_sym, @operation.last.to_i)
    end

    item = if @stressed
      item % @lcm
    else
      ( item / 3 ).floor
    end

    item % @test == 0 ? @true_monkey.catch_item!(item) :
                        @false_monkey.catch_item!(item)
  end

  def catch_item!(item)
    @items.unshift item
  end
end

def pt1(input_file)
  monkeys = Monkey.read_file_create_monkeys(input_file)

  20.times do
    monkeys.each &:take_turn!
  end

  monkey_business = monkeys.map(&:items_inspected).sort.last(2).inject &:*
  puts "Level of monkey business for #{input_file}: #{monkey_business}"
end


def pt2(input_file)
  monkeys = Monkey.read_file_create_monkeys(input_file, true)

  10000.times do
    monkeys.each &:take_turn!
  end

  monkey_business = monkeys.map(&:items_inspected).sort.last(2).inject &:*
  puts "Level of monkey business for #{input_file}: #{monkey_business}"
end

pt1("sample.txt")
pt1("input.txt")
puts
pt2("sample.txt")
pt2("input.txt")
