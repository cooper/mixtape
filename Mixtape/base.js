var global = window, $ = function (e) { return document.getElementById(e); };

var console = { log: function (log) { ObjC.NSLog_(log); } };

// load coffeescript
var cscript  = document.createElement("script");
cscript.type = "text/javascript";
cscript.src  = "coffeescript.js";

var fscript  = document.createElement("script");
fscript.type = "text/coffeescript";
fscript.src  = "feb.coffee";

// inject coffeescript and feb
document.head.appendChild(fscript);
document.head.appendChild(cscript);