lines = File.read('input.txt').lines.map { |l| l.strip.chars }

scores = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}

matches = {
  '(' => ')',
  '{' => '}',
  '[' => ']',
  '<' => '>'
}

completes = []
lines.each do |chars|
  stack = []
  err = false

  chars.each do |char|
    match = matches[char]

    if match
      stack.push(match)
    else
      if (c = stack.pop) != char
        puts "Syntax Error! Expected #{c}, but found #{char} instead."
        err = true
        break
      end
    end
  end

  next if err

  if stack.length != 0
    score = stack.reverse.inject(0) { |sum, char| sum*5 + scores[char]}
    completes.push score
    puts "#{score} autocomplete #{stack.reverse.join} "
  else
    puts "Good line"
  end
end

p completes.sort[completes.length/2]
