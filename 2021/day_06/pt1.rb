raw = File.read('input.txt')
fishes = raw.split(',').map(&:to_i)
fish_sizes = Array.new(9,0)
fishes.each { |f| fish_sizes[f] += 1 }

80.times do
  spawned = fish_sizes.shift
  fish_sizes[6] += spawned
  fish_sizes.push(spawned)
end

p fish_sizes.sum
