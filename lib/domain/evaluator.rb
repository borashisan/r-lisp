module Domain
  class Evaluator
    class << self
      def eval(exp, env)
        case exp
        when Integer
          exp
        when Symbol
          env.get(exp)
        when Array
          evaluate_list(exp, env)
        else
          raise "Unknown expression type: #{exp.inspect}"
        end
      end

      private

      def evaluate_list(exp, env)
        operator, *args = exp

        case operator
        when :quote
          args[0]
        when :define
          symbol, value_exp = args
          value = eval(value_exp, env)
          env.define(symbol, value)
          value
        when :if
          test_exp, then_exp, else_exp = args
          if eval(test_exp, env)
            eval(then_exp, env)
          else
            eval(else_exp, env)
          end
        else
          # TODO: ifやdefineを実装していく
          raise "Unknown operator: #{operator}"
        end
      end
    end
  end
end
