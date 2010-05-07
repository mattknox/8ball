class EightBallVisitor
  module Helpers
    def leaf?(node); node.childNodes.empty?; end
    def get_child_count(parent); parent.childNodes.size; end
    def get_child(parent, index); parent.childNodes[index]; end
    def first_child(parent); parent.child_nodes[0]; end
    def get_index_of_child(parent, child); parent.childNodes.index child; end

    def visit_or_null(node)
      node ? visit(node) : "null"
    end

    def gather(*args)
      args
    end

    def gather_with(str, *args)
      raise NotYetImplemented
    end

    def mangle(method)
      "ruby#{desymbolify(method)}"
    end

    def desymbolify(methodname)
      SYMBOLS_STRINGS.inject(methodname) { |acc, arr| acc.gsub(arr[0], arr[1]) }
    end

    def compile_function(name, args, body)
      gather("function #{name} #{compile_arglist(args)}",
             compile_function_body(body).wrap_with(["{\n", "\n}\n"]))
    end

    def compile_function_body(node)
      if node.is_a? Java::OrgJrubyAst::BlockNode
        gather( [node.child_nodes.to_a[0..-2].map { |n| visit(n) } +
                 ["return #{visit(node.child_nodes.to_a.last)};"]].join(";\n"))
      else
        "return #{visit(node)};"
      end
    end

    def compile_arglist(node)
      if node.class == Java::OrgJrubyAst::ArrayNode or node.class == Java::OrgJrubyAst::MultipleAsgnNode
        node.child_nodes.to_a.map { |n| visit(n) }.to_comma_list
      elsif node
        puts node.inspect
        node.name.wrap_with("()")
      else
        puts 'got into a weird arglist'
        puts caller
      end
    end
  end
end
