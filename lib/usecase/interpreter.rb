module Usecase
  class Interpreter
    class << self
      attr_reader :global_env

      def setup_primitives
        @global_env = Domain::Environment.new
        @global_env.define(:car, ->(args) { Infrastructure::Primitives.car(args[0]) })
        @global_env.define(:cdr, ->(args) { Infrastructure::Primitives.cdr(args[0]) })
        @global_env.define(:cons, ->(args) { Infrastructure::Primitives.cons(args[0], args[1]) })
        @global_env.define(:atom, ->(args) { Infrastructure::Primitives.atom(args[0]) })
        @global_env.define(:eq, ->(args) { Infrastructure::Primitives.eq(args[0], args[1]) })
      end
    end

    setup_primitives
  end
end
