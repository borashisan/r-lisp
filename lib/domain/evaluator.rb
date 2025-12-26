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
        when :cond
          args.each do |clause|
            test, action = clause
            if test == :else || eval(test, env)
              return eval(action, env)
            end
          end
          nil
        when :lambda
          params, body = args
          lambda do |actual_args|
            new_env = Environment.new(env)
            params.zip(actual_args).each do |name, val|
              new_env.define(name, val)
            end
            eval(body, new_env)
          end
        else
          procedure = eval(operator, env)
          evaluated_args = args.map { |arg| eval(arg, env) }
          procedure.call(evaluated_args)
        end
      end
    end
  end
end
