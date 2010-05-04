class EightBallVisitor
  module Trivial
    def visit_nil_node(node)
      ''
    end

    def visit(node)
      node.accept(self)
    end

    def visit_newline_node(node)
      visit(node.next_node)
    end

    def visit_array_node(node)
      node.child_nodes.to_a.map { |n| visit(n) }
    end

    def visit_root_node(node)
      visit(node.body_node)
    end
  end
end
