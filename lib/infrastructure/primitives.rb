module Infrastructure
  module Primitives
    def self.car(list)
      raise "car: argument must be a list" unless list.is_a?(Array)
      list.first
    end

    def self.cdr(list)
      raise "cdr: argument must be a list" unless list.is_a?(Array)
      list[1..-1] || []
    end

    def self.cons(item, list)
      raise "cons: argument must be a list" unless list.is_a?(Array)
      [item] + list
    end

    def self.atom(exp)
      !exp.is_a?(Array)
    end

    def self.eq?(a, b)
      a == b
    end

    def self.add(a, b) = a + b
    def self.sub(a, b) = a - b
    def self.mul(a, b) = a * b
    def self.div(a, b) = a.fdiv(b)

    def self.lt(a, b) = a < b
    def self.gt(a, b) = a > b
    def self.le(a, b) = a <= b
    def self.ge(a, b) = a >= b

    def self.display(val)
      print val
      val
    end

    def self.newline
      puts
      nil
    end

  end
end
