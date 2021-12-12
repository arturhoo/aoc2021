# frozen_string_literal: true

require './d10'

describe D10 do
  let(:input) do
    <<~EXAMPLE_INPUT
      [({(<(())[]>[[{[]{<()<>>
      [(()[<>])]({[<{<<[]>>(
      {([(<{}[<>[]}>{[]{[(<()>
      (((({<>}<{<{<>}{[]{[]{}
      [[<[([]))<([[{}[[()]]]
      [{[{({}]{}}([{[{{{}}([]
      {<[[]]>}<{[{[{[]{()[[[]
      [<(<(<(<{}))><([]([]()
      <{([([[(<>()){}]>(<<{{
      <{([{{}}[<[[[<>{}]]]>[]]
    EXAMPLE_INPUT
  end

  it 'works for part 1' do
    expect(D10.new(input).p1).to eq(26_397)
  end

  it 'works for part 2' do
    expect(D10.new(input).p2).to eq(:fix_me)
  end
end
