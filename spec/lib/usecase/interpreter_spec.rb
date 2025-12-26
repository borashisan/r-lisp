RSpec.describe Usecase::Interpreter do
  let(:interpreter) { Usecase::Interpreter.new }

  it 'リスト操作の基本関数が正しく動作すること' do
    expect(interpreter.execute("(car (quote (1 2 3)))")).to eq(1)

    expect(interpreter.execute("(cons 1 (quote (2 3)))")).to eq([1, 2, 3])
  end

  it '複合的な式を評価すること' do
    code = "(if (atom 1) (quote yes) (quote no))"
    expect(interpreter.execute(code)).to eq(:yes)
  end
end
