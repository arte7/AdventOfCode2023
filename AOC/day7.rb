# frozen_string_literal: true
require 'benchmark'

puts Benchmark.measure {
  file_path = 'input/day7_input.txt'
  # r is readmode
  file = File.open(file_path, 'r')

  input = <<~INPUT
  32T3K 765
  T55J5 684
  KK677 28
  KTJJT 220
  QQQJA 483
  INPUT

  MAPPING = {
    '2' => '2',
    '3' => '3',
    '4' => '4',
    '5' => '5',
    '6' => '6',
    '7' => '7',
    '8' => '8',
    '9' => '9',
    'T' => '10',
    'J' => '11',
    'Q' => '12',
    'K' => '13',
    'A' => '14'
  }

  hash = {}
  result = []
  line_number = 0
  array = []

  input.each_line do |line|
    line_number += 1
    fin = line_number - 1
    start = 0
    mid = (start + fin)/2

    e = line.split(" ")
    map = e[0].split('').map { |num| MAPPING[num] }.map(&:to_i)
    array << [map, [e[1].to_i], e[0]]

    p mid
    p array[mid]
    # if array[mid] == digit
    #   return mid
    # elsif digit < array[mid]
    #   fin = mid - 1
    # elsif digit > array[mid]
    #   start = mid + 1
    # end
  end



  p array

  file.close
}
