# frozen_string_literal: true

file_path = 'input/day1_input.txt'
# r is readmode
file = File.open(file_path, 'r')
result = []

input = <<~INPUT
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
INPUT

MAPPING = {
  "one" => '1',
  'two' => '2',
  'three' => '3',
  'four' => '4',
  'five' => '5',
  'six' => '6',
  'seven' => '7',
  'eight' => '8',
  'nine' => '9',
  '1' => '1',
  '2' => '2',
  '3' => '3',
  '4' => '4',
  '5' => '5',
  '6' => '6',
  '7' => '7',
  '8' => '8',
  '9' => '9'
}

file.each_line.map do |line|
  nums = []

  numbers = line.match(/#{MAPPING.keys.join("|")}/)
  reverse = line.reverse.match(/#{MAPPING.keys.map(&:reverse).join("|")}/)
  nums << MAPPING[numbers[0]]
  nums << MAPPING[reverse[0].reverse]
  result << nums.join.to_i
end
p result.sum
file.close
