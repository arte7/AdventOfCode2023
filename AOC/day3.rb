# frozen_string_literal: true
require 'benchmark'

puts Benchmark.measure {
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

  numbers = []
  matrix = []
  signs = []
  i = 0
  j = 0

  NUMS = /\d+/
  CHARS = /[^0-9.]/
  file.each_line do |line|
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
      if !matrix[r-1][c-3].match(NUMS).nil? && !matrix[r-1][c-2].match(NUMS).nil?
        range = matrix[r-1][c-3...c]
      elsif matrix[r-1][c-3].match(NUMS).nil?
        range = matrix[r-1][c-2...c]
      elsif matrix[r-1][c-2].match(NUMS).nil?
        range = matrix[r-1][c-1]
      end
      numbers << range.scan(NUMS).join.to_i
    end

    # here is something missing
    if step_up.match(NUMS).nil? && !step_up_right.match(NUMS).nil?
      if !matrix[r-1][c+3].match(NUMS).nil? && !matrix[r-1][c+2].match(NUMS).nil?
        range = matrix[r-1][c+1..c+3]
      elsif matrix[r-1][c+3].match(NUMS).nil?
        range = matrix[r-1][c+1..c+2]
      elsif matrix[r-1][c-2].match(NUMS).nil?
        range = matrix[r-1][c+1]
      end
      numbers << range.scan(NUMS).join.to_i
    end

    if !step_up.match(NUMS).nil? && !step_up_left.match(NUMS).nil? && !step_up_right.match(NUMS).nil?
      range = matrix[r-1][c-1..c+1]
      numbers <<  range.scan(NUMS).join.to_i
    end

    if !step_up.match(NUMS).nil? && step_up_left.match(NUMS).nil?
      if !matrix[r-1][c+2].match(NUMS).nil? && !matrix[r-1][c+1].match(NUMS).nil?
        range = matrix[r-1][c..c+2]
      elsif matrix[r-1][c+2].match(NUMS).nil?
        range = matrix[r-1][c..c+1]
      elsif matrix[r-1][c+1].match(NUMS).nil?
        range = matrix[r-1][c]
      end
      numbers <<  range.scan(NUMS).join.to_i
    end

    if !step_up.match(NUMS).nil? && step_up_right.match(NUMS).nil?
      if !matrix[r-1][c-2].match(NUMS).nil? && !matrix[r-1][c-1].match(NUMS).nil?
        range = matrix[r-1][c-2..c]
      elsif matrix[r-1][c-2].match(NUMS).nil?
        range = matrix[r-1][c-1..c]
      elsif matrix[r-1][c-1].match(NUMS).nil?
        range = matrix[r-1][c]
      end
      numbers <<  range.scan(NUMS).join.to_i
    end

    # prototype
    if !step_left.match(NUMS).nil?
      if !matrix[r][c-3].match(NUMS).nil? && !matrix[r][c-2].match(NUMS).nil?
        range = matrix[r][c-3...c]
      elsif matrix[r][c-3].match(NUMS).nil?
        range = matrix[r][c-2...c]
      elsif matrix[r][c-2].match(NUMS).nil?
        range = matrix[r][c-1]
      end
      numbers <<  range.scan(NUMS).join.to_i
    end

    if !step_right.match(NUMS).nil?
      if !matrix[r][c+3].match(NUMS).nil? && !matrix[r][c+2].match(NUMS).nil?
        range = matrix[r][c+1..c+3]
      elsif matrix[r][c+3].match(NUMS).nil?
        range = matrix[r][c+1..c+2]
      elsif matrix[r][c+2].match(NUMS).nil?
        range = matrix[r][c+1]
      end
      numbers <<  range.scan(NUMS).join.to_i
    end

    if step_down.match(NUMS).nil? && !step_down_left.match(NUMS).nil?
      if !matrix[r+1][c-3].match(NUMS).nil? && !matrix[r+1][c-2].match(NUMS).nil?
        range = matrix[r+1][c-3...c]
      elsif matrix[r+1][c-3].match(NUMS).nil?
        range = matrix[r+1][c-2...c]
      elsif matrix[r+1][c-2].match(NUMS).nil?
        range = matrix[r+1][c-1]
      end
      numbers <<  range.scan(NUMS).join.to_i
    end

    if step_down.match(NUMS).nil? && !step_down_right.match(NUMS).nil?
      if !matrix[r+1][c+3].match(NUMS).nil? && !matrix[r+1][c+2].match(NUMS).nil?
        range = matrix[r+1][c+1..c+3]
      elsif matrix[r+1][c+3].match(NUMS).nil?
        range = matrix[r+1][c+1..c+2]
      elsif matrix[r+1][c+2].match(NUMS).nil?
        range = matrix[r+1][c+1]
      end
      numbers <<  range.scan(NUMS).join.to_i
    end

    if !step_down.match(NUMS).nil? && !step_down_left.match(NUMS).nil? && !step_down_right.match(NUMS).nil?
      range = matrix[r+1][c-1..c+1]
      numbers <<  range.scan(NUMS).join.to_i
    end

    if !step_down.match(NUMS).nil? && step_down_left.match(NUMS).nil?
      if !matrix[r+1][c+2].match(NUMS).nil? && !matrix[r+1][c+1].match(NUMS).nil?
        range = matrix[r+1][c..c+2]
      elsif matrix[r+1][c+2].match(NUMS).nil?
        range = matrix[r+1][c..c+1]
      elsif matrix[r+1][c+1].match(NUMS).nil?
        range = matrix[r+1][c]
      end
      numbers <<  range.scan(NUMS).join.to_i
    end

    if !step_down.match(NUMS).nil? && step_down_right.match(NUMS).nil?
      if !matrix[r+1][c-2].match(NUMS).nil? && !matrix[r+1][c-1].match(NUMS).nil?
        range = matrix[r+1][c-2..c]
      elsif matrix[r+1][c-2].match(NUMS).nil?
        range = matrix[r+1][c-1..c]
      elsif matrix[r+1][c-1].match(NUMS).nil?
         range = matrix[r+1][c-1]
      end
      numbers <<  range.scan(NUMS).join.to_i
    end
  end

  p "entries in numbers #{numbers}"
  p numbers.sum

  file.close
}
