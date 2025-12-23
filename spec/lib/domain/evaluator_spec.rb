RSpec.describe Domain:: Evaluator do
  let(:env) { Domain::Environment.new }

  describe '.eval' do
    it '数値を評価すると、その数値自身が返ること' do
      expect(Domain::Evaluator.eval(1, env)).to eq(1)
    end

    it 'シンボルを評価すると、環境から値を取得すること' do
      env.define(:x, 10)
      expect(Domain::Evaluator.eval(:x, env)).to eq(10)
    end

    it 'quote形式を評価すると、引数が評価されずに返ること' do
      expression = [:quote, [:a, :b]]
      expect(Domain::Evaluator.eval(expression, env)).to eq([:a, :b])
    end
  end
end
