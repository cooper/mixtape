var global = window, $ = function (e) { return document.getElementById(e); };

var console = { log: function (log) { ObjC.NSLog_(log); } };

// load coffeescript
var cscript  = document.createElement("script");
cscript.type = "text/javascript";
cscript.src  = "coffeescript.js";

// load coffeescript
var lscript  = document.createElement("script");
lscript.type = "text/javascript";
lscript.src  = "less.js";

var fscript  = document.createElement("script");
fscript.type = "text/coffeescript";
fscript.src  = "feb.coffee";

var scripts = document.getElementsByTagName("style");
for (var i in scripts) {
    if (scripts[i].type == "feb/less") scripts[i].type = "text/less";
}
    

// inject coffeescript and feb
document.head.appendChild(fscript);
document.head.appendChild(cscript);
document.head.appendChild(lscript);