module Usecase
  class Interpreter
    def initialize
      @global_env = Domain::Environment.new
      setup_primitives
    end

    def execute(code)
      tokens = Infrastructure::Lexer.tokenize(code);
      expression = Infrastructure::Parser.parse(tokens);
      Domain::Evaluator.eval(expression, @global_env)
    end

    private

    def setup_primitives
      @global_env = Domain::Environment.new
      @global_env.define(:car, ->(args) { Infrastructure::Primitives.car(args[0]) })
      @global_env.define(:cdr, ->(args) { Infrastructure::Primitives.cdr(args[0]) })
      @global_env.define(:cons, ->(args) { Infrastructure::Primitives.cons(args[0], args[1]) })
      @global_env.define(:atom, ->(args) { Infrastructure::Primitives.atom(args[0]) })
      @global_env.define(:eq?, ->(args) { Infrastructure::Primitives.eq?(args[0], args[1]) })

      @global_env.define(:+, ->(args) { Infrastructure::Primitives.add(args[0], args[1]) })
      @global_env.define(:-, ->(args) { Infrastructure::Primitives.sub(args[0], args[1]) })
      @global_env.define(:*, ->(args) { Infrastructure::Primitives.mul(args[0], args[1]) })
      @global_env.define(:/, ->(args) { Infrastructure::Primitives.div(args[0], args[1]) })

      @global_env.define(:>, ->(args) { Infrastructure::Primitives.gt(args[0], args[1]) })
      @global_env.define(:<, ->(args) { Infrastructure::Primitives.lt(args[0], args[1]) })
      @global_env.define(:>=, ->(args) { Infrastructure::Primitives.ge(args[0], args[1]) })
      @global_env.define(:<=, ->(args) { Infrastructure::Primitives.le(args[0], args[1]) })
    end
  end
end
