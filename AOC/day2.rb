# frozen_string_literal: true

file_path = 'input/day2_input.txt'
# r is readmode
file = File.open(file_path, 'r')

input = <<~INPUT
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
INPUT

game = []

file.each_line do |line|
  line.strip!

  blue = line.scan(/\d+ blue/).map(&:to_i).max
  green = line.scan(/\d+ green/).map(&:to_i).max
  red = line.scan(/\d+ red/).map(&:to_i).max

  if red <= 12 && green <= 13 && blue <= 14
    game << line.scan(/\d+:/)
  end
end

p game.flatten.map(&:to_i).sum
file.close
