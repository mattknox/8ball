require "#{File.dirname(File.expand_path(__FILE__))}/8ball_visitor"

class EightBallCompiler
  def self.parse(ruby)
    r = org.jruby.Ruby.getDefaultInstance
    r.parse(ruby, "test_code", r.getCurrentContext.getCurrentScope, 0, true)
  end

  def self.compile_string(ruby, include_prelude = true)
    prelude = include_prelude ? prelude : ""
    prelude + parse(ruby).accept(EightBallVisitor.new).to_a.join("")
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
    # primitives.js has most of the runtime we need.
    "require('../js/primitives');\n"
  end
end
