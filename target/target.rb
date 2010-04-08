# this file is intended to serve as a target for 8ball compilation.

class Target
  class InnerClass < Fixnum
  end

  def self.foo(x,y)
  rescue
  end

  def foo(a, b, c = 7, *args, &block)
    [a, b, c, args, block]
  end
end
