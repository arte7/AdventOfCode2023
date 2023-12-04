# frozen_string_literal: true
require 'benchmark'

puts Benchmark.measure {
  file_path = 'input/day4_input.txt'
  # r is readmode
  file = File.open(file_path, 'r')

  input = <<~INPUT
  Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
  Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
  Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
  Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
  Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
  Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
  INPUT

  result = []
  # card = []


  file.each_line do |line|
    line.strip!
    acc = 0
    points = 0
    e = line.split(":")
    nums = e[1].split("|")
    # card = e[0].scan(/\d+/)
    winning = nums[0].split(" ").map(&:to_i)
    my_nums = nums[1].split(" ").map(&:to_i)

    winning.each do |win|
      my_nums.each do |num|
        if win == num
          acc += 1
        end
      end
    end

    if acc >= 1
      points += 1
      acc -= 1
    end

    while acc > 0 do
      points *= 2
      acc -= 1
    end
    result << points
  end
  p result.sum

  file.close
}

# benchmark 0.003666   0.000215   0.003881 (  0.004164)
