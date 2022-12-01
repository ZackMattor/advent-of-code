lines = File.read('input.txt').lines.map { |l| l.strip.chars }

# ): 3 points.
# ]: 57 points.
# }: 1197 points.
# >: 25137 points.

scores = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137
}

matches = {
  '(' => ')',
  '{' => '}',
  '[' => ']',
  '<' => '>'
}

errs = []
lines.each do |chars|
  stack = []

  chars.each do |char|
    match = matches[char]

    if match
      stack.push(match)
    else
      if (c = stack.pop) != char
        puts "Syntax Error! Expected #{c}, but found #{char} instead."
        errs.push(char)
        break
      end
    end
  end
end

p errs.map { |err| scores[err] }.sum
