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

    it 'defineで変数を評価できること' do
      Domain::Evaluator.eval([:define, :a, 100], env)
      expect(env.get(:a)).to eq(100)
    end

    it 'ifで条件分岐ができること' do
      expect(Domain::Evaluator.eval([:if, 1, 10, 20], env)).to eq(10)

      env.define(:condition, false)
      expect(Domain::Evaluator.eval([:if, :condition, 10, 20], env)).to eq(20)
    end
  end
end
