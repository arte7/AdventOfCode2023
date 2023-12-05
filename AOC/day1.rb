# frozen_string_literal: true

file_path = 'input/day1_input.txt'
# r is readmode
file = File.open(file_path, 'r')
numbers = []

file.each_line do |line|
  ary = []
  nums = []
  line.each_char { |c| ary << c }

  num_ary = ary.select {|v| v =~ /[1-9]/ }
  nums << num_ary.first
  nums << num_ary.last
  numbers << nums.join.to_i
end
puts numbers.sum

file.close
