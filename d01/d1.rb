# frozen_string_literal: true

# https://adventofcode.com/2021/day/1
class D1
  def initialize(input)
    @numbers = input.split("\n").map(&:to_i)
  end

  def p1
    count = 0
    prev = nil
    @numbers.each do |num|
      count += 1 if prev && num > prev
      prev = num
    end
    count
  end

  def p2
    count = 0
    prev = nil
    window = []
    @numbers.each do |num|
      window.shift if window.length == 3
      window << num
      count += 1 if prev && window.sum > prev
      prev = window.sum if window.length == 3
    end
    count
  end
end

if $PROGRAM_NAME == __FILE__
  file = File.read('input1.txt')

  puts(D1.new(file).p1)
  puts(D1.new(file).p2)
end
