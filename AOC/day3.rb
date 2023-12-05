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

NUMS = /[\d+]/
CHARS = /[!@#$%^&*_+{}\[\]:;<>,?~\\\/\-]/
input.each_line do |line|
  line = line.strip!
  matrix << line
end
rows = matrix.length

find_chars = for j in 0...rows do
  len = matrix[j].length
  for i in 0...len do
    # p matrix[j][i] # for debugging
    unless matrix[j][i].match(CHARS).nil?
      signs << [j, i]
    end
  end
end

find_adjacent = for i in 0...(signs.length) do
  p "sings in find_adjacent #{signs[i]}"
  r = signs[i][0] # rows aka j
  c = signs[i][1] # columns aka i
  if r > 0
    row_up = matrix[r - 1][c]
    if row_up.match(NUMS).nil?
      p "left range #{@far_left_range}"
      # p @far_left_range.scan(NUMS).join.to_i
      @far_left_range = if c >= 4 && matrix[r - 1][c-1].scan(NUMS).nil?
        s = c-4
        far_left_range = matrix[r-1][s...c]
        p "first loop left #{far_left_range}"
      elsif c >= 3
        s = c-3
        far_left_range = matrix[r-1][s...c]
        p "second loop left #{far_left_range}"
      elsif c >= 2
        s = c-2
        far_left_range = matrix[r-1][s...c]
        p "third loop left #{far_left_range}"
      end
    end
  else
    p "weiß nit"
  end

  # else
  #   start_left_range = matrix[r-1][c..c+3]
  #   p "third loop left #{start_left_range}"
  # end
end


p "signs in the end #{signs}"
file.close
