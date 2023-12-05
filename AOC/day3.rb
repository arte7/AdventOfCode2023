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
  p "sings in find_adjacent #{signs[i]}"
  r = signs[i][0] # rows aka j
  c = signs[i][1] # columns aka i
  koor = signs[i]

  # koordinates of direct adjacent to rule 345.* etc out
  step_up_left = matrix[r-1][c-1]
  step_up = matrix[r-1][c]
  step_left = matrix[r][c-1]
  step_right = matrix[r][c+1]
  step_down_left = matrix[r+1][c-1]
  step_down = matrix[r+1][c]

  # first go up left
  if r > 0 && step_up.match(NUMS).nil?
    # check for the edges
    if c >= 3 && !step_up_left.match(NUMS).nil?
      s = c-3
      range = matrix[r-1][s...c]
      p "first loop left #{range}"
      unless matrix[r-1][s].match(NUMS).nil?
        koor[0] -= 1
        koor[1] -= 3
      else
        koor[0] -= 1
        koor[1] -= 2
      end
      p "koordinates of number #{index[koor] = range.scan(NUMS).join.to_i}"
      p "koor #{koor}"
    elsif c >= 2 && !step_up_left.match(NUMS).nil?
      s = c-2
      range = matrix[r-1][s...c]
      p "second loop left #{range}"
      koor[0] -= 1
      koor[1] -= 2
      index[koor] = range.scan(NUMS).join.to_i
    end
  elsif r > 0 && !step_up.match(NUMS).nil?
    range = matrix[r - 1][c..c+2]
    koor[0] -= 1
    p koor
    index[koor] = range.scan(NUMS).join.to_i
    p " ----- step up right"
    p " koordinates #{index[koor] = range.scan(NUMS).join.to_i}"
  elsif r > 0 && step_up.match(NUMS).nil?
    range = matrix[r - 1][c+1..c+3]
    koor[0] -= 1
    koor[1] += 1
    p koor
    index[koor] = range.scan(NUMS).join.to_i
    p " ----- step up far right"
    p " koordinates #{index[koor] = range.scan(NUMS).join.to_i}"
    # then go left
  elsif c >= 3 && !step_left.match(NUMS).nil?
    p " ----- step left"
    s = c-3
    range = matrix[r][s...c]
    p "first loop left #{range}"
    unless matrix[r][s].match(NUMS).nil?
      koor[1] -= 3
    else
      koor[1] -= 2
    end
    p "koordinates of number #{index[koor] = range.scan(NUMS).join.to_i}"
    p "koor #{koor}"
    # go right
  elsif c >= 3 && !step_right.match(NUMS).nil?
    p " ----- step right"
    s = c-3
    range = matrix[r][s...c]
    p "first loop left #{range}"
    unless matrix[r][s].match(NUMS).nil?
      koor[1] -= 3
    else
      koor[1] -= 2
    end
    p "koordinates of number #{index[koor] = range.scan(NUMS).join.to_i}"
    p "koor #{koor}"
    #go down left
    if step_down.match(NUMS).nil?
      # check for the edges
      if c >= 3 && !step_down_left.match(NUMS).nil?
        s = c-3
        range = matrix[r+1][s...c]
        p "down left #{range}"
        unless matrix[r-1][s].match(NUMS).nil?
          koor[0] -= 1
          koor[1] -= 3
        else
          koor[0] -= 1
          koor[1] -= 2
        end
        p "koordinates of number #{index[koor] = range.scan(NUMS).join.to_i}"
        p "koor #{koor}"
      elsif c >= 2 && !step_up_left.match(NUMS).nil?
        s = c-2
        range = matrix[r-1][s...c]
        p "second loop left #{range}"
        koor[0] -= 1
        koor[1] -= 2
        index[koor] = range.scan(NUMS).join.to_i
      end
    elsif r > 0 && !step_up.match(NUMS).nil?
      range = matrix[r - 1][c..c+2]
      koor[0] -= 1
      p koor
      index[koor] = range.scan(NUMS).join.to_i
      p " ----- step up right"
      p " koordinates #{index[koor] = range.scan(NUMS).join.to_i}"
    elsif r > 0 && step_up.match(NUMS).nil?
      range = matrix[r - 1][c+1..c+3]
      koor[0] -= 1
      koor[1] += 1
      p koor
      index[koor] = range.scan(NUMS).join.to_i
      p " ----- step up far right"
      p " koordinates #{index[koor] = range.scan(NUMS).join.to_i}"
    end
  end
end

p "entries in index #{index}"

p "signs in the end #{signs}"
file.close
