items = File.read('input.txt').split(',').map(&:to_i).sort

results = (0..items.max).map do |i|
  {
    usage: items.map { |item| (1..(( item - i ).abs)).sum }.sum,
    position: i
  }
end

p results.sort_by { |a| a[:usage] }[0]
