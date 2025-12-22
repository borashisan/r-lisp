module Infrastructure
  class Parser
    class << self
      def parse(tokens)
        raise "unexpected EOF" if tokens.empty?

        token = tokens.shift

        case token
        when '('
          list = []
          while tokens.first != ')'
            raise "unexpected EOF" if tokens.empty?
            list << parse(tokens) # 再帰的に中身をパース
          end
          tokens.shift # ')' を捨てる
          list
        when ')'
          raise "unexpected )"
        else
          atom(token)
        end
      end

      private

      def atom(token)
        # 数値ならIntegerに、それ以外はSymbolに変換
        if token.match?(/^-?\d+$/)
          token.to_i
        else
          token.to_sym
        end
      end
    end
  end
end
