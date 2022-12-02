require 'awesome_print'
require 'pry'

SCORE_LOSE = 0
SCORE_DRAW = 3
SCORE_WIN = 6

SCORE_ROCK = 1
SCORE_PAPER = 2
SCORE_SCISSORS = 3

CHAR_ROCK = 'A'
CHAR_PAPER = 'B'
CHAR_SCISSORS = 'C'

def day_02_pt1(input_file)
  mapping = {
    CHAR_ROCK => {
      'X' => SCORE_DRAW + SCORE_ROCK,
      'Y' => SCORE_WIN + SCORE_PAPER,
      'Z' => SCORE_LOSE + SCORE_SCISSORS,
    },
    CHAR_PAPER => {
      'X' => SCORE_LOSE + SCORE_ROCK,
      'Y' => SCORE_DRAW + SCORE_PAPER,
      'Z' => SCORE_WIN + SCORE_SCISSORS,
    },
    CHAR_SCISSORS => {
      'X' => SCORE_WIN + SCORE_ROCK,
      'Y' => SCORE_LOSE + SCORE_PAPER,
      'Z' => SCORE_DRAW + SCORE_SCISSORS,
    },
  }

  ans = File.read(input_file).lines.sum { |play| mapping.dig(*play.split(' ')) }
  puts "Answer for Day 2 pt1 for #{input_file}: #{ans}"
end

def day_02_pt2(input_file)
  mapping = {
    CHAR_ROCK => {
      'X' => SCORE_LOSE + SCORE_SCISSORS,
      'Y' => SCORE_DRAW + SCORE_ROCK,
      'Z' => SCORE_WIN + SCORE_PAPER,
    },
    CHAR_PAPER => {
      'X' => SCORE_LOSE + SCORE_ROCK,
      'Y' => SCORE_DRAW + SCORE_PAPER,
      'Z' => SCORE_WIN + SCORE_SCISSORS,
    },
    CHAR_SCISSORS => {
      'X' => SCORE_LOSE + SCORE_PAPER,
      'Y' => SCORE_DRAW + SCORE_SCISSORS,
      'Z' => SCORE_WIN + SCORE_ROCK,
    },
  }

  ans = File.read(input_file).lines.sum { |play| mapping.dig(*play.split(' ')) }
  puts "Answer for Day 2 pt2 for #{input_file}: #{ans}"
end

day_02_pt1("sample.txt")
day_02_pt1("input.txt")
puts
day_02_pt2("sample.txt")
day_02_pt2("input.txt")
