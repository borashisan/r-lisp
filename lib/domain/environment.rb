module Domain
  class Environment
    def initialize(outer = nil)
      @values = {}
      @outer = outer
    end

    def define(symbol, value)
      @values[symbol] = value
    end

    def get(symbol)
      return @values[symbol] if @values.key?(symbol)

      if @outer
        @outer.get(symbol)
      else
        raise "Unbound variable: #{symbol}"
      end
    end
  end
end
