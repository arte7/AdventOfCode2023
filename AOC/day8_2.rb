# frozen_string_literal: true
require 'benchmark'
require 'prime'

puts Benchmark.measure {
  file_path = 'input/day8_input.txt'
  # r is readmode
  file = File.open(file_path, 'r')

  input = <<~INPUT
  LR

  11A = (11B, XXX)
  11B = (XXX, 11Z)
  11Z = (11B, XXX)
  22A = (22B, XXX)
  22B = (22C, 22C)
  22C = (22Z, 22Z)
  22Z = (22B, 22B)
  XXX = (XXX, XXX)
  INPUT

  result = []

  hash = {}
  instructions = 0
  line_number = 0
  starting_nodes = []

  file.each_line do |line|
    line.strip!

    if line_number >= 2
      e = line.split(" = ")
      clean = e[1].gsub(/\(|\)/, '')
      directions = clean.split(", ")
      hash[e[0]] = directions
      if e[0][2] == "A"
        starting_nodes << e[0]
      end
    elsif line_number == 0
      instructions = line
    end
    line_number += 1
  end

  instructions = instructions.gsub(/L/, '0').gsub(/R/, '1')
  len = instructions.length - 1

  starting_nodes.each do |note|
    index = 0
    steps = 1
    lookup = hash[note][instructions[index].to_i]
    loop do
      if lookup[2] == "Z"
        result << steps
        break
      else
        steps += 1
        index += 1
        if index > len
          index = 0
        end
        lookup = hash[lookup][instructions[index].to_i]
      end
    end
  end

  p result.reduce(:lcm)
  file.close
}
# benchmark 0.039434   0.000702   0.040136 (  0.041579)
