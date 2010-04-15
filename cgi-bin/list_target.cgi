#!/usr/bin/env /Users/ben/jruby/bin/jruby

require 'cgi'

cgi = CGI.new

puts "Content-type: application/json"
puts ""

$stdout.write "["
$stdout.write Dir["../target/*.rb"].map{|ea| "\"#{ea[3..-1]}\""}.join(", ")
$stdout.puts "]"
