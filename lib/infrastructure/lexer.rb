module Infrastructure
  class Lexer
    def self.tokenize(input)
      input.gsub('(', ' ( ')
           .gsub(')', ' ) ')
           .split
    end
  end
end