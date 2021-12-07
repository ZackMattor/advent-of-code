items = File.read('input.txt').split(',').map(&:to_i).sort

results = (0..items.max).map do |i|
  {
    usage: items.inject { |sum, item| n=( item - i ).abs; sum + n*(n+1)/2 },
    position: i
  }
end

p results.sort_by { |a| a[:usage] }[0]
