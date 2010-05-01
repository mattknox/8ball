require '8ball_visitor'

class EightBallCompiler
  def self.parse(ruby)
    r = org.jruby.Ruby.getDefaultInstance
    r.parse(ruby, "test_code", r.getCurrentContext.getCurrentScope, 0, true)
  end

  def self.compile_string(ruby)
    parse(ruby).accept(EightBallVisitor.new)
  end

  def self.compile_to_file(input_file, output_file)
    File.open(output_file) do |f|
      f.write compile_file(input_file)
    end
  end

  def self.compile_file(input_file)
    compile_string(File.read(input_file))
  end

  def self.prelude
    # this outputs the js runtime we need.
    [File.read("lib.js"),
     File.read("primitives.js")].join("\n")
  end
end
