RSpec.describe Infrastructure::Parser do
  describe '.parse' do
    it '単一の数値をパースできること' do
      tokens = ['1']
      expect(Infrastructure::Parser.parse(tokens)).to eq(1)
    end

    it '単一のシンボルをパースできること' do
      tokens = ['+']
      expect(Infrastructure::Parser.parse(tokens)).to eq(:+)
    end

    it '単純なリストをパースできること' do
      tokens = ['(', '+', '1', '2', ')']
      expect(Infrastructure::Parser.parse(tokens)).to eq([:+, 1, 2])
    end

    it 'ネストしたリストをパースできること' do
      tokens = ['(', 'car', '(', 'quote', '(' , 'a', 'b', ')', ')', ')']
      expected = [:car, [:quote, [:a, :b]]]
      expect(Infrastructure::Parser.parse(tokens)).to eq(expected)
    end

    it '括弧の閉じ忘れでエラーを投げること' do
      tokens = ['(', '+', '1']
      expect { Infrastructure::Parser.parse(tokens) }.to raise_error(StandardError, "unexpected EOF")
    end

    it '閉じ括弧から始まっている場合はエラーを投げること' do
      tokens = [')', '(', '+', '1', '2', ')']
      expect { Infrastructure::Parser.parse(tokens) }.to raise_error(StandardError, "unexpected )")
    end
  end
end
