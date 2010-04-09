# stuff to aid in development
# I like dumping this into the jirb environment with
#  eval(File.read("dev.rb"))

eval(File.read("8ball.rb"))

class EightBallCompiler
  def self.cs(ruby)
    puts "we're about to compile:\n\n#{ruby}\n"
    pp (ast = parse(ruby))
    puts "\n\n"
    puts ast.accept(EightBallVisitor.new)
  end
end

class Object
  def method_missing(meth, *args)
    puts "method missing: #{meth}"
    pp args
  end
end

e = EightBallCompiler
v = EightBallVisitor.new

avi = File.read("target/avi.rb")
control = File.read("target/control.rb")
d = File.read("target/def.rb")
klass = File.read("target/klass.rb")
simple = File.read("target/simple.rb")
inner_class = File.read("target/inner_class.rb")
bm = File.read("target/bm.rb")
x = File.read("target/x.rb")

target = bm
ast = e.parse(target)
d = ast.child_nodes.first.child_nodes.first
e.cs target
