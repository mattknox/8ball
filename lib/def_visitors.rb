class EightBallVisitor
  module DefVisitors
    def visit_class_node(node)
      gather(node.first.name, "<", node.last.name) #, visit(node.get_body_node))
    end
  end
end
