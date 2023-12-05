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

index = {}
matrix = []
signs = []
koor = []
i = 0
j = 0

NUMS = /[\d+]/
CHARS = /[!@#$%^&*_+{}\[\]:;<>,?~\\\/\-]/
input.each_line do |line|
  line = line.strip!
  matrix << line
end
rows = matrix.length
line_length = matrix[0].length

# find_special chars
for j in 0...rows do
  for i in 0...line_length do
    unless matrix[j][i].match(CHARS).nil?
      signs << [j, i]
    end
  end
end

# find_adjacent
for i in 0...(signs.length) do
  r = signs[i][0] # rows aka j
  c = signs[i][1] # columns aka i
  koor = signs[i]

  # koordinates of direct adjacent to rule 345.* etc out
  step_up_left = matrix[r-1][c-1]
  step_up = matrix[r-1][c]
  step_up_right = matrix[r-1][c+1]
  step_left = matrix[r][c-1]
  step_right = matrix[r][c+1]
  step_down_left = matrix[r+1][c-1]
  step_down = matrix[r+1][c]
  step_down_right = matrix[r+1][c+1]

  # first go up left
  if step_up.match(NUMS).nil? && !step_up_left.match(NUMS).nil?
    range = matrix[r-1][c-3...c]
    unless matrix[r-1][c-3].match(NUMS).nil?
      koor[0] -= 1
      koor[1] -= 3
    else
      koor[0] -= 1
      koor[1] -= 2
    end
    index[koor] = range.scan(NUMS).join.to_i
  end

  if step_up.match(NUMS).nil? && !step_up_right.match(NUMS).nil?
    range = matrix[r - 1][c+1..c+3]
    koor[0] -= 1
    koor[1] += 1
    index[koor] = range.scan(NUMS).join.to_i
  end

  if !step_up.match(NUMS).nil? && !step_up_left.match(NUMS).nil? && !step_up_right.match(NUMS).nil?
    range = matrix[r - 1][c-1..c+1]
    koor[0] -= 1
    koor[1] -= 1
    index[koor] = range.scan(NUMS).join.to_i
  end

  if !step_up.match(NUMS).nil? && step_up_left.match(NUMS).nil?
    range = matrix[r-1][c..c+2]
    koor[0] -= 1
    index[koor] = range.scan(NUMS).join.to_i
  end

  if !step_up.match(NUMS).nil? && step_up_right.match(NUMS).nil?
    range = matrix[r-1][c-2..c]
    unless matrix[r-1][c-2].match(NUMS).nil?
      koor[0] -= 1
      koor[1] -= 2
    else
      koor[0] -= 1
      koor[1] -= 1
    end
    index[koor] = range.scan(NUMS).join.to_i
  end

  if !step_left.match(NUMS).nil?
    range = matrix[r][c-3...c]
    unless matrix[r][c-3].match(NUMS).nil?
      koor[1] -= 3
    else
      koor[1] -= 2
    end
    index[koor] = range.scan(NUMS).join.to_i
  end

  if !step_right.match(NUMS).nil?
    range = matrix[r][c+1..c+3]
    koor[1] += 1
    index[koor] = range.scan(NUMS).join.to_i
  end

  if step_down.match(NUMS).nil? && !step_down_left.match(NUMS).nil?
    range = matrix[r+1][c-3...c]
    unless matrix[r+1][c-3].match(NUMS).nil?
      koor[0] += 1
      koor[1] -= 3
    else
      koor[0] += 1
      koor[1] -= 2
    end
    index[koor] = range.scan(NUMS).join.to_i
  end

  if step_down.match(NUMS).nil? && !step_down_right.match(NUMS).nil?
    range = matrix[r+1][c+1..c+3]
    koor[0] += 1
    koor[1] += 1
    index[koor] = range.scan(NUMS).join.to_i
  end

  if !step_down.match(NUMS).nil? && !step_down_left.match(NUMS).nil? && !step_down_right.match(NUMS).nil?
    range = matrix[r+1][c-1..c+1]
    koor[0] += 1
    koor[1] -= 1
    index[koor] = range.scan(NUMS).join.to_i
  end

  if !step_down.match(NUMS).nil? && step_down_left.match(NUMS).nil?
    range = matrix[r+1][c..c+2]
    koor[0] += 1
    index[koor] = range.scan(NUMS).join.to_i
  end

  if !step_down.match(NUMS).nil? && step_down_right.match(NUMS).nil?
    range = matrix[r+1][c-2..c]
    koor[0] += 1
    koor[1] -= 2
    index[koor] = range.scan(NUMS).join.to_i
  end
end

p "entries in index #{index}"
p index.values.sum

file.close
