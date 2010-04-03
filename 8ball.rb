test_code = <<EOF
   def zot
       3+4
   end
EOF

require "java"

class JavascriptVisitor
  include org.jruby.ast.visitor.NodeVisitor

  def visit(node)
    node.accept(self)
  end

  def visitRootNode(node)
    visit(node.bodyNode)
  end

  def visitNewlineNode(node)
    visit(node.nextNode)
  end

  def visitDefnNode(node)
    print "\nfunction " + node.getName + "() {\n"
    print "return "
    visit(node.bodyNode)
    print "\n}"
  end

  def visitCallNode(node)
    visit(node.receiverNode)
    print " #{node.getName} "
    visit(node.argsNode.getLast)
  end

  def visitFixnumNode(node)
    print node.value
  end
end

test_code = File.read("/Users/mknox/twitter/lib/decider.rb")
r = org.jruby.Ruby.getDefaultInstance
ast = r.parse(test_code, "test_code",
r.getCurrentContext.getCurrentScope, 0, true)
File.open("jruby_example", "w").do |f|
  f.write ast.inspect
end
ast.accept(JavascriptVisitor.new)
