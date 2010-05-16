class Target
  class InnerClass < Fixnum
    class InnerInnerClass < Number
      def initialize(x)
        super
      end
    end
    def inner_target_instance_method(x)
      x + 1
    end
  end

  def target_instance_method(x)
    x + 7
  end

  def self.target_class_method(x)
    x + 2
  end

  def Target.other_class_method(x)
    x + 3
  end

  class << self
    def yet_another_class_method(x)
      x + 4
    end
  end
end
