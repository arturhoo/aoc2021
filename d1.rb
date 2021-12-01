# frozen_string_literal: true

def input
  File.readlines('input1.txt').map(&:to_i)
end

def count_increases
  count = 0
  prev = nil
  input.each do |num|
    count += 1 if prev && num > prev
    prev = num
  end
  count
end

def count_sliding_windows_increases
  count = 0
  prev = nil
  window = []
  input.each do |num|
    window.shift if window.length == 3
    window << num
    count += 1 if prev && window.sum > prev
    prev = window.sum if window.length == 3
  end
  count
end

puts count_increases
puts count_sliding_windows_increases
