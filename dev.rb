# stuff to aid in development
# I like dumping this into the jirb environment with
#  eval(File.read("8ball.rb"))

e = EightBallCompiler
v = EightBallVisitor.new

avi = File.read("target/avi.rb")
control = File.read("target/control.rb")
d = File.read("target/def.rb")
klass = File.read("target/klass.rb")
simple = File.read("target/simple.rb")
target = File.read("target/target.rb")
x = File.read("target/x.rb")

ast = e.parse(simple)
d = ast.child_nodes.first.child_nodes.first
matt = ast.child_nodes.first.child_nodes.first.child_nodes.first
av = ast.child_nodes.first.child_nodes.to_a.last
#e.cs(simple)
