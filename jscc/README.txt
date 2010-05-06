This is an attempt at creating a Ruby LALR parser in pure JavaScript that can
execute on V8.

Ingredients:
* jscc.js and driver_v8.js_ are the the JS/CC parser generator, as retrieved
  from <http://jscc.jmksf.com/> and built for V8 target.
* v8sh is a V8 shell binary, compiled for Intel 32-bit Mac OS X. It is 
  included in source form in the JS/CC distribution and can be rebuilt from it
  if necessary (i.e. for a different platform).
* ruby.par is a Ruby BNF grammar, in the format that JS/CC understands.

To build a Ruby parser:
./v8sh jscc.js ruby.par > rubyparser.js

To run the Ruby parser (i.e. using one of the "target" files):
./v8sh rubyparser.js ../target/ben.rb

The parser doesn't really do anything right now aside from verifying that the
passed .rb file is indeed a valid Ruby program - it has no semantic actions.
The next step is to fill it out with semantic actions that generate a JS
equivalent of the Ruby code, thus implementing a Ruby->JS translator.

That said, the parser currently fails to parse even a single-token Ruby
program. I don't understand the reasons for that and will need to do some
debugging to figure it out. If you want to chime in, have a go at it!