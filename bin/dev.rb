# stuff to aid in development
# I like dumping this into the jirb environment with
#  eval(File.read("dev.rb"))
require 'pp'
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
    puts "self: #{self.inspect}"
    puts "method missing: #{meth}"
    pp args
  end
end

e = EightBallCompiler
v = EightBallVisitor.new
h = { }

Dir.glob('target/*').each do |path|
  name = path.match(/target\/(.*).rb/)[1]
  h[name] = File.read(path)
end

target = h['bm']
ast = e.parse(target)
d = ast.child_nodes.first.child_nodes.first
e.cs target

