# frozen_string_literal: true

require './d12'

describe D12 do
  let(:input1) do
    <<~EXAMPLE_INPUT
      start-A
      start-b
      A-c
      A-b
      b-d
      A-end
      b-end
    EXAMPLE_INPUT
  end

  let(:input2) do
    <<~EXAMPLE_INPUT
      dc-end
      HN-start
      start-kj
      dc-start
      dc-HN
      LN-dc
      HN-end
      kj-sa
      kj-HN
      kj-dc
    EXAMPLE_INPUT
  end

  let(:input3) do
    <<~EXAMPLE_INPUT
      fs-end
      he-DX
      fs-he
      start-DX
      pj-DX
      end-zg
      zg-sl
      zg-pj
      pj-he
      RW-he
      fs-DX
      pj-RW
      zg-RW
      start-pj
      he-WI
      zg-he
      pj-fs
      start-RW
    EXAMPLE_INPUT
  end

  it 'works for part 1' do
    expect(D12.new(input1).p1).to eq(10)
    expect(D12.new(input2).p1).to eq(19)
    expect(D12.new(input3).p1).to eq(226)
  end

  it 'works for part 2' do
    expect(D12.new(input1).p2).to eq(:fix_me)
    expect(D12.new(input2).p2).to eq(:fix_me)
    expect(D12.new(input3).p2).to eq(:fix_me)
  end
end
