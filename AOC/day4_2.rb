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
  cards = Hash.new(1)
  cards[1] = 1
  lines = 0

  file.each_line do |line|
    line.strip!
    lines += 1
    acc = 0

    e = line.split(":")
    nums = e[1].split("|")
    current_card = e[0].scan(/\d+/).map(&:to_i)[0]
    winning = nums[0].split(" ").map(&:to_i)
    my_nums = nums[1].split(" ").map(&:to_i)

    # the number of wins I have
    winning.each do |win|
      my_nums.each do |num|
        if win == num
          acc += 1
        end
      end
    end

    i = current_card
    multiplier = cards[current_card]

    # adding the number of cards to cards hash with multiplier
    while acc > 0
      i += 1
      cards[i] += (multiplier)
      acc -= 1
    end
  end


  # initializing a hash with default doesn't return nil on +=1
  # but it doesn't return a value on hash.values if nothing was added
  lost_items = lines - cards.size

  p cards.values.sum + lost_items

  file.close
}

# benchmark   0.004325   0.000261   0.004586 (  0.005018)
