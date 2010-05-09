class EightBallVisitor
  module DefVisitors
    def visit_class_node(node)
      gather("Class.define(#{node.first.name}, #{node.last.name}, #{visit(node.get_body_node)})")
    end

    def visit_defn_node(node)
      compile_function(node.get_name, node.args_node, node.body_node)
    end
  end
end
