#! /usr/local/bin/jruby

# this will take in the names of ruby files and spit the js compiled
# from those files, or from STDIN if no files are given, to STDOUT
require "#{File.dirname(File.expand_path(__FILE__))}/../lib/8ball"
require 'open3'
require 'fileutils'

class EightBallInterpreter
  include Open3

  attr_accessor :files_to_delete

  def initialize
    @files_to_delete = []
  end

  def extract_filenames
    # return an array of js filenames
    if ARGV.empty?
      code = STDIN.readlines.join("\n")
      [(@files_to_delete = [push_to_temp_js(code)])]
    else
      compile_to_js_files(ARGV)
    end
  end

  def compile_to_js_files(files)
    js_files = []
    files.each do |f|
      if File.exists?(f)
        dir = File.dirname(File.expand_path(f))
        js_filename = f.split('/').last.sub(/\.rb$/, ".js")
        full_filename = "#{dir}/#{js_filename}"
        js_files.push full_filename
        @files_to_delete.push full_filename
        File.open(full_filename, 'w') do |out|
          rb = File.read(f)
          out.write EightBallCompiler.compile_string(rb)
        end
      else
        raise 'file not found'
      end
    end
    js_files
  end

  def run
    files = extract_filenames
    Open3.popen3("node #{files}") { |stdin, stdout, stderr|
      stdout.each { |line| puts line }
    }
    FileUtils.rm @files_to_delete if @files_to_delete.size > 0
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

