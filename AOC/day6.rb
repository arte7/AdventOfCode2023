# frozen_string_literal: true

file_path = 'input/day6_input.txt'
# r is readmode
file = File.open(file_path, 'r')

input = <<~INPUT
Time:      7  15   30
Distance:  9  40  200
INPUT

result = []
data = []


file.each_line do |line|
  e = line.split(":")
  name = e[0]
  values = e[1].chomp.split(" ").map(&:to_i)
  data << values
end

len = data[0].size - 1

for i in 0..len do
  time = data[0][i]

  distance = data[1][i]
  charge_time = 0

  halftime = (time/2).floor
  peek = (time - halftime) * halftime

  loop do
    return "won't fix" if peek < distance
    seconds_to_fin = time - charge_time
    millimeters = (seconds_to_fin * charge_time)
    if millimeters > distance
      start = charge_time
      fin = time - (start-1)
      range = start..charge_time
      possible_wins = time - (start*2) +1
      result << possible_wins
      break
    end
    charge_time += 1
  end
end
p result.flatten.inject(:*)


file.close
