#! /usr/local/bin/jruby

# this will take in the names of ruby files and spit the js compiled
# from those files, or from STDIN if no files are given, to STDOUT
require "../lib/8ball"

if ARGV.empty?
  code = STDIN.readlines.join("\n")
else
  code = ARGV.map { |name| File.read(name) }.join("\n")
end

puts EightBallCompiler.compile_string(code)
