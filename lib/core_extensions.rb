class String
  def first
    self[0].chr
  end

  def last
    self[-1].chr
  end

  def wrap_with(wrapper)
    if wrapper.length == 2
      wrapper.first + self + wrapper.last
    elsif wrapper.length == 1
      wrapper + self + wrapper
    else
      raise "bad argument"
    end
  end
end

class Array
  def to_comma_list
    self.join(", ").wrap_with("()")
  end

  def wrap_with(wrapper)
    if wrapper.length == 2
      wrapper.first.to_a + self + wrapper.last.to_a
    elsif wrapper.length == 1
      wrapper.to_a + self + wrapper.to_a
    else
      raise "bad argument"
    end
  end
end

# should move this into dev, as it is not needed for the compiler.
module Java
  module OrgJrubyAst
    class Node
      def leaf?; self.childNodes.empty?; end
      def child_count; self.childNodes.size; end
      def child(index); self.childNodes[index]; end
      def first_child; self.child_nodes[0]; end
      def index_of_child(child); self.childNodes.index child; end
      def descend_tree(*indices)
        indices.inject(self) { |node, i| node.child(i)}
      end
    end
  end
end
