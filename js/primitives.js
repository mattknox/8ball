var sys = require('sys')
function puts(string) { sys.puts(string);};

/* these should eventually do ruby-style case dispatch, and should be replaced
 with calls to naked js primitives when possible. */
Number.prototype.rubyplus = function(a) { return a + this; }; 
Object.prototype.rubyplus = function(a) { return this.concat(a); }; 
String.prototype.rubyplus = function(a) { return this + a; }; 
Number.prototype.rubyminus = function(a) { return a - this; };
Object.prototype.rubytruthy = function (x) { return (x == null || x === false) ? false : x; };

