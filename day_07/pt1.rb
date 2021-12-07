raw = File.read('input.txt')
items = raw.split(',').map(&:to_i).sort
max = items.max

results = []

max.times do |i|
  fuel = 0
  items.each do |item|
    fuel += ( item - i ).abs

  end

  results.push({ usage: fuel, position: i })
end

p results.sort_by { |a| a[:usage] }[0]
