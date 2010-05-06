var sys = require('sys'),
http = require('http');

function run_benchmark(network_calls, method_calls, strings, string_size) {
    var i = 0,
    result = "",
    str = "";

    var local = http.createClient(80, '127.0.0.1');
    for(i = 0; i < network_calls; i += 1) {
        var request = local.request("GET", "/", {});
        request.addListener('response',
                            function (response) {
                                response.addListener('data', function (chunk) {
                                                         str += chunk;
                                                     });
                            });
        request.close();
    }

    for(i = 0; i < method_calls; i += 1) {
        even(100);
    }
    for(i = 0; i < strings; i += 1) {
        result += str.slice(0, string_size);
    }
    return result.length;
}

function even(x) {
    if (0 == x) {
        return true;
    } else {
        return odd(x - 1);
    }
}

function odd(x) {
    if (0 == x) {
        return false;
    } else {
        return even(x - 1);
    }
}


run_benchmark(0,2000,3000,300);
