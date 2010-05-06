var sys = require('sys');

EightBall = function() {};

EightBall.puts = function puts(string) { sys.puts(string);};
Object.prototype.rubytruthy = function (x) { return (x == null || x === false) ? false : x; };
Number.prototype.to_s = function () { return this.toString(); };

/* these should eventually do ruby-style case dispatch, and should be replaced
with calls to naked js primitives when possible. */

Number.prototype.rubyplus = function(a) { return a + this; };
Object.prototype.rubyplus = function(a) { return this.concat(a); };
String.prototype.rubyplus = function(a) { return this + a; };

Number.prototype.rubyminus = function(a) { return this - a; };
Object.prototype.rubyminus = function(a) { };

// need to rename this or times below.
//Number.prototype.rubytimes = function(a) { return this * a;};
Number.prototype.rubytimes = function(f) {
    for(var i = 0; i < this; i++){
        f(i);
    }
    return i;
};

String.prototype.rubytimes = function(a) {
    var ret = "";
    for( var i = 0; i < a; i++) {
        ret += this;
    }
    return ret;
};
