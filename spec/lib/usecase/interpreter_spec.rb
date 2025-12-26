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

  it '再帰(階乗)が正しく計算できること' do
    interpreter.execute("(define fact (lambda (n) (if (< n 1) 1 (* n (fact (- n 1))))))")

    expect(interpreter.execute("(fact 5)")).to eq(120)
    expect(interpreter.execute("(fact 10)")).to eq(3628800)
  end

  it 'cond を使った再帰が動作すること' do
    # フィボナッチ数列
    # (define fib (lambda (n) (cond ((eq n 0) 0) ((eq n 1) 1) (else (+ (fib (- n 1)) (fib (- n 2)))))))
    code = <<-LISP
      (define fib (lambda (n)
        (cond ((eq? n 0) 0)
              ((eq? n 1) 1)
              (else (+ (fib (- n 1)) (fib (- n 2)))))))
    LISP
    interpreter.execute(code)
    expect(interpreter.execute("(fib 7)")).to eq(13)
  end
end
