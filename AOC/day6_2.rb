# frozen_string_literal: true
require 'benchmark'

puts Benchmark.measure {
  file_path = 'input/day6_input.txt'
  # r is readmode
  file = File.open(file_path, 'r')

  input = <<~INPUT
  Time:      7  15   30
  Distance:  9  40  200
  INPUT

  data = []
  result = 0

  file.each_line do |line|
    e = line.split(":")
    name = e[0]
    values = e[1].chomp.split(" ").join("").to_i
    data << values
  end

  time = data[0]
  distance = data[1]
  charge_time = 0

  loop do
    seconds_to_fin = time - charge_time
    millimeters = (seconds_to_fin * charge_time)
    if millimeters > distance
      start = charge_time
      fin = time - (start-1)
      range = start..charge_time
      possible_wins = time - (start*2) +1
      result = possible_wins
      break
    end
    charge_time += 1
  end

  p result

  file.close
}
