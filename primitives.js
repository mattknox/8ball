Number.prototype.primplus = function(y) { return this + y; };
Number.prototype.times = function (fn) { for (var i = 0; i < this; i++) { fn(i) }}

function puts(string) {console.log(string)};