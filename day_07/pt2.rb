raw = File.read('input.txt')
items = raw.split(',').map(&:to_i).sort
max = items.max

results = []

max.times do |i|
  fuel = 0
  items.each do |item|

    fuel += ( (1..(( item - i ).abs)).inject { |a,b|a + b } || 0 )

  end

  results.push({ usage: fuel, position: i })
end

p results.sort_by { |a| a[:usage] }[0]
