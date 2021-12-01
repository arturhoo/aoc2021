# frozen_string_literal: true

def count_increases
  count = 0
  prev = nil
  File.readlines('input1.txt').map(&:to_i).each do |num|
    count += 1 if prev && num > prev
    prev = num
  end
  count
end

puts count_increases
