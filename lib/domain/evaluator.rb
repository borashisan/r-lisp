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
        operator = exp[0]

        case operator
        when :quote
          exp[1]
        else
          # TODO: ifやdefineを実装していく
          raise "Unknown operator: #{operator}"
        end
      end
    end
  end
end
