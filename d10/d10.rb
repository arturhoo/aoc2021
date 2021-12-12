# frozen_string_literal: true

require 'Set'
require 'pp'

P1_SCOREBOARD = {
  '}' => 1197,
  ']' => 57,
  ')' => 3,
  '>' => 25_137
}.freeze

P2_SCOREBOARD = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}.freeze

# https://adventofcode.com/2021/day/10
class D10
  def initialize(input)
    lines = input.split("\n")
    @lines = lines.map { |l| Line.new(l) }
  end

  def p1
    score = 0
    @lines.each do |line|
      corrupt, token = line.corrupt?
      score += P1_SCOREBOARD[token] if corrupt
    end
    score
  end

  def p2
    scores = []
    incomplete = @lines.reject { |l| l.corrupt?[0] }
    incomplete.each do |line|
      score = 0
      completion_string = line.completion_string
      completion_string.chars.each do |char, _idx|
        score *= 5
        score += P2_SCOREBOARD[char]
      end
      scores << score
    end

    scores.sort!
    scores[scores.length / 2]
  end
end

OPENING = Set['[', '(', '{', '<'].freeze
CLOSING = Set[']', ')', '}', '>'].freeze
MAP = {
  '}' => '{',
  ']' => '[',
  ')' => '(',
  '>' => '<'
}.freeze

class Line
  def initialize(line_str)
    @line = line_str.chars
  end

  def corrupt?
    stack = []
    @line.each do |token|
      if OPENING.include?(token)
        stack << token
        next
      end
      matching_chunk = MAP[token]
      return true, token if stack[-1] != matching_chunk

      stack.pop
    end
    [false, nil]
  end

  def completion_string
    stack = []
    @line.each do |token|
      if OPENING.include?(token)
        stack << token
        next
      end
      stack.pop
    end
    stack.map { |t| MAP.invert[t] }.reverse.join
  end
end

if $PROGRAM_NAME == __FILE__
  file = File.read('input10.txt')

  puts(D10.new(file).p1)
  puts(D10.new(file).p2)
end
