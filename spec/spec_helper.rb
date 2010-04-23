require 'spec'

$LOAD_PATH.unshift ".."

def cs(str)
  EightBallCompiler.compile_string(str).join("")
end
