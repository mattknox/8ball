#! /usr/local/bin/jruby

# this will take in the names of ruby files and spit the js compiled
# from those files, or from STDIN if no files are given, to STDOUT
require "#{File.dirname(File.expand_path(__FILE__))}/../lib/8ball"
require 'open3'
require 'fileutils'

class EightBallInterpreter
  include Open3

  attr_accessor :files_to_delete

  def extract_filenames
    # return an array of js filenames
    if ARGV.empty?
      code = STDIN.readlines.join("\n")
      [(@files_to_delete = [push_to_temp_js(code)])]
    else
      ARGV.clone
    end
  end

  def run
    files = extract_filenames
    Open3.popen3("node #{files}") { |stdin, stdout, stderr|
      stdout.each { |line| puts line }
    }
    FileUtils.rm @files_to_delete
  end

  def push_to_temp_js(code)
    js = EightBallCompiler.compile_string(code)
    filename = "out8ball#{Time.now.to_i}"
    File.open(filename, 'w') { |f| f.write js }
    filename
  end
end

EightBallInterpreter.new.run

# require 'open3'
# include Open3
# files = "js/primitives.js"
# stdin, stdout, stderr =  Open3.popen3("v8 #{files}")
# stdout.read

