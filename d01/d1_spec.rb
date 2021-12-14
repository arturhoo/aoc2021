# frozen_string_literal: true

require './d1'

describe D1 do
  let(:input) do
    <<~EXAMPLE_INPUT
      199
      200
      208
      210
      200
      207
      240
      269
      260
      263
    EXAMPLE_INPUT
  end

  it 'works for part 1' do
    expect(D1.new(input).p1).to eq(7)
  end

  it 'works for part 2' do
    expect(D1.new(input).p2).to eq(5)
  end
end
