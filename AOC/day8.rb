# frozen_string_literal: true
require 'benchmark'

puts Benchmark.measure {
  file_path = 'input/day8_input.txt'
  # r is readmode
  file = File.open(file_path, 'r')

  input = <<~INPUT
  LLR

  AAA = (BBB, BBB)
  BBB = (AAA, ZZZ)
  ZZZ = (ZZZ, ZZZ)
  INPUT

  result = []

  hash = {}
  instructions = 0
  steps = 1 # in the end +1
  line_number = 0

  file.each_line do |line|
    line.strip!

    if line_number >= 2
      e = line.split(" = ")
      clean = e[1].gsub(/\(|\)/, '')
      directions = clean.split(", ")
      hash[e[0]] = directions
    elsif line_number == 0
      instructions = line
    end
    line_number += 1
  end
  instructions = instructions.gsub(/L/, '0').gsub(/R/, '1')
  len = instructions.length - 1
  index = 0
  lookup = hash["AAA"][instructions[index].to_i]
  loop do
    if lookup == "ZZZ"
      p steps
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

  file.close
}
# benchmark   0.007973   0.000410   0.008383 (  0.008705)
