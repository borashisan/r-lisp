RSpec.describe Infrastructure::Lexer do
  describe '.tokenize' do
    it '基本構文を正しく解析できること' do
      input = "(+ 1 2)"
      expected = ['(', '+', '1', '2', ')']
      expect(Infrastructure::Lexer.tokenize(input)).to eq(expected)
    end

    it 'ネストした構文を正しく解析できること' do
      input = "(defun f (x) (* x x))"
      expected = ['(', 'defun', 'f', '(', 'x', ')', '(', '*', 'x', 'x', ')', ')']
      expect(Infrastructure::Lexer.tokenize(input)).to eq(expected)
    end 

    it '余分な空白を無視できること' do
      input = "  ( +   1 2)"
      expected = ['(', '+', '1', '2', ')']
      expect(Infrastructure::Lexer.tokenize(input)).to eq(expected)
    end
  end
end
