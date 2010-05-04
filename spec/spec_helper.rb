require 'spec'
# run these with jruby -S spec -fs spec/8ball_spec.rb
$LOAD_PATH.unshift ".."

def cs(str)
  EightBallCompiler.compile_string(str, false).to_a.join("")
end

