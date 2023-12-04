# frozen_string_literal: true

file_path = 'input/day3_input.txt'
# r is readmode
file = File.open(file_path, 'r')

input = <<~INPUT
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
INPUT

result = []
matrix = []
signs = []
i = 0
j = 0

NUMS = /[\d]/
CHARS = /[!@#$%^&*_+{}\[\]:;<>,?~\\\/\-]/
input.each_line do |line|
  line = line.strip!
  matrix << line
end
col = matrix.length - 1

find_chars = for j in 0..col do
  len = matrix[j].length - 1
  for i in 0..len do
    # p matrix[j][i] # for debugging
    unless matrix[j][i].match(CHARS).nil?
      signs << [j, i]
    end
  end
end

find_adjacent = for i in 0..(signs.length - 1) do
  p "sings in find_adjacent #{signs[i]}"
  c = signs[i][0] # columns || j
  e = signs[i][1] # elements || i
  if c > 0
    c -
  else
  end
end


p "signs in the end #{signs}"
file.close
