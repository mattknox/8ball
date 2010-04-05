test_code = <<EOF
	class Foo
		def zot
			3+4
		end
	end
EOF

require "java"

class EightBallVisitor
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

	def visitCallNode(node)
		visit(node.receiverNode)
		print ".#{mangle(node.getName)}("
		visit(node.argsNode.getLast)
		print ")"
	end

	def visitFixnumNode(node)
		print "(#{node.value})"
	end

	def mangle(method)
		method.gsub("+", "$plus")
	end
end

class ClassDefVisitor < EightBallVisitor
	def visitClassNode(node)
		puts "this.define_class(\"#{node.getCPath.getName}\","
		puts "function() {"
		ClassDefVisitor.new.visit(node.bodyNode)
		puts "})"
	end

	def visitDefnNode(node)
		puts "this.define_method(\"#{node.getName}\","
		puts "function() {"
		print "return "
		MethodDefVisitor.new.visit(node.bodyNode)
		puts "})"
	end
end

class MethodDefVisitor < EightBallVisitor
end

r = org.jruby.Ruby.getDefaultInstance
ast = r.parse(test_code, "test_code", r.getCurrentContext.getCurrentScope, 0, true)
ast.accept(ClassDefVisitor.new)
