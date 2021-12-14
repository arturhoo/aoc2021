# frozen_string_literal: true

require 'set'
require 'pp'

# https://adventofcode.com/2021/day/8
class D8
  def initialize(input)
    parse_input(input)
  end

  def p1
    cnt = 0
    @entries.each do |_patterns, value_digits|
      value_digits.each do |d|
        num_segments = d.length
        possible_digits = NUM_SEGMENTS_TO_DIGITS[num_segments]
        cnt += 1 if possible_digits.length == 1
      end
    end
    cnt
  end

  def p2
    sum = 0
    @entries.each do |patterns, value_digits|
      display = Display.new(patterns)
      display.filter_permutations
      display.find_permutation
      sum += output_value_from_entry(display, value_digits)
    end
    sum
  end

  private

  def parse_input(input)
    lines = input.split("\n")
    @entries = []
    lines.each do |line|
      patterns, value_digits = line.split('|').map(&:split)
      @entries << [patterns, value_digits]
    end
  end

  def output_value_from_entry(display, value_digits)
    value_digits
      .map { |digit_pattern| display.read_pattern(digit_pattern) }
      .join
      .to_i
  end
end

ALL_SEGMENTS = %i[a b c d e f g].freeze

NUM_SEGMENTS_TO_DIGITS = {
  2 => Set[1],
  3 => Set[7],
  4 => Set[4],
  5 => Set[2, 3, 5],
  6 => Set[0, 6, 9],
  7 => Set[8]
}.freeze

DIGITS_TO_SEGMENTS = {
  0 => %i[a b c e f g].to_set,
  1 => %i[c f].to_set,
  2 => %i[a c d e g].to_set,
  3 => %i[a c d f g].to_set,
  4 => %i[b c d f].to_set,
  5 => %i[a b d f g].to_set,
  6 => %i[a b d e f g].to_set,
  7 => %i[a c f].to_set,
  8 => %i[a b c d e f g].to_set,
  9 => %i[a b c d f g].to_set
}.freeze

class Display
  attr_reader :translation

  def initialize(patterns)
    @patterns = patterns
    @permutations = ALL_SEGMENTS.dup.permutation.to_a
  end

  def filter_permutations
    @patterns.each do |pattern|
      possible_digits = NUM_SEGMENTS_TO_DIGITS[pattern.length]
      chars = pattern.chars.map(&:to_sym)
      next if possible_digits.length > 1

      possible_digits.each do |digit|
        real_segments = DIGITS_TO_SEGMENTS[digit]
        real_segments.each do |seg|
          seg_idx = ALL_SEGMENTS.index(seg)
          @permutations.select! { |p| chars.include?(p[seg_idx]) }
        end
      end
    end
  end

  def find_permutation
    @permutations.each do |perm|
      if permutation_valid?(perm)
        @translation = perm_to_map(perm)
        break
      end
    end
  end

  def read_pattern(pattern)
    chars = pattern.chars.map(&:to_sym)
    translated_chars = chars.map { |c| @translation[c] }.to_set
    DIGITS_TO_SEGMENTS.select { |_k, v| v == translated_chars }.keys[0]
  end

  private

  def permutation_valid?(perm)
    map = perm_to_map(perm)
    @patterns.each do |pattern|
      chars = pattern.chars.map(&:to_sym)
      translated_chars = chars.map { |c| map[c] }.to_set
      return false unless DIGITS_TO_SEGMENTS.values.include?(translated_chars)
    end
    true
  end

  def perm_to_map(perm)
    map = {}
    perm.each_with_index do |sym, idx|
      map[sym] = ALL_SEGMENTS.at(idx)
    end
    map
  end
end

if $PROGRAM_NAME == __FILE__
  file = File.read('input8.txt')

  puts(D8.new(file).p1)
  puts(D8.new(file).p2)
end
