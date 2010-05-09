require 'lib/8ball'

def test_all
  Dir.glob('target/*').each do |path|
    name = path.match(/target\/(.*).rb/)[1]
    ruby = File.read(path)
    puts "file: #{name}"
    puts "containing ruby:\n#{ruby}"
    puts "compiles to:\n#{EightBallCompiler.compile_string}"
  end
end

def reload(f)
  eval File.read("lib/#{f}.rb")
end

e = EightBallCompiler
v = EightBallVisitor.new
a = e.parse 'lambda {|x| x + 1}'
b = e.parse 'Proc.new {|x| x + 1 }'
d = e.parse 'class Foo < Fixnum;def bar; 1+2;end;end'
x = a.child_nodes.first.next_node
a.accept v
