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

  it '算術演算の基本関数が正しく動作すること' do
    expect(interpreter.execute("(+ 1 2)")).to eq(3)
    expect(interpreter.execute("(- 1 2)")).to eq(-1)
    expect(interpreter.execute("(* 1 2)")).to eq(2)
    expect(interpreter.execute("(/ 1 2)")).to eq(0.5)

    expect(interpreter.execute("(* 3 (+ 4 5))")).to eq(27)
  end

  it 'ユーザー定義関数(lambda)の中で計算ができること' do
    interpreter.execute("(define square (lambda (x) (* x x)))")
    expect(interpreter.execute("(square 4)")).to eq(16)
  end
end
