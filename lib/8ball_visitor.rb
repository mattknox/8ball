require "java"
require "#{File.dirname(File.expand_path(__FILE__))}/core_extensions"
require "#{File.dirname(File.expand_path(__FILE__))}/trivial"
require "#{File.dirname(File.expand_path(__FILE__))}/call_visitors"
require "#{File.dirname(File.expand_path(__FILE__))}/helpers"

class EightBallVisitor
  include org.jruby.ast.visitor.NodeVisitor
  include EightBallVisitor::Trivial
  include EightBallVisitor::CallVisitors
  include EightBallVisitor::Helpers

  class NotYetImplemented < StandardError; end

  SYMBOLS_STRINGS = [['+', 'plus'],
                     ['-', 'minus'],
                     ['!', 'bang'],
                     ['?', 'question']]

  def visit_local_asgn_node(node)
    var_or_nil = (node.get_depth == 0 ? 'var ' : nil)
    gather("#{var_or_nil}#{node.get_name} = #{node.child_nodes.map { |n| visit(n) }};")
  end

  def visit_block_node(node)
    node.child_nodes.map { |x| visit(x) }
  end

  def visit_if_node(node)
    gather("(#{visit_or_null(node.condition)}) ? #{visit_or_null(node.get_then_body)} : #{visit_or_null(node.get_else_body)}")
  end

  def visit_false_node(node)
    "false"
  end

  def visit_true_node(node)
    "true"
  end

  def visit_fixnum_node(node)
    "(#{node.value})"
  end

  def visit_bignum_node(node) # js doesn't really support bignums
    "(#{node.value})"
  end

  def visit_float_node(node)
    "(#{node.value})"
  end

  def visit_regexp_node(node)
    "/#{node.get_value}/"
  end

  def visit_str_node(node)
    "('#{node.value}')"
  end

  def visit_const_node(node)
    node.get_name
  end

  def visitClassNode(node)
    gather("this.define_class(\"#{node.getCPath.getName}\",",
           "function() {",
           visit(node.bodyNode),
           "})")
  end

  def visitDefnNode(node)
    compile_function(node.get_name, node.args_node.args, node.body_node)
  end

  def visitArgsNode(node)
    node.args.child_nodes.to_a.map {|x| x.name}.join(", ")
  end

  def visitLocalVarNode(node)
    node.get_name
  end

  def visitDVarNode(node)
    node.get_name
  end

  def visit_and_node(node)
    node.child_nodes.map{|n| visit(n) }.join(" && ")
  end

  def visit_or_node(node)
    node.child_nodes.map{|n| visit(n) }.join(" || ")
  end

  def visit_true_node(node)
    "true"
  end

  def visit_false_node(node)
    "false"
  end
end
