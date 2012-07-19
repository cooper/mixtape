var global  = window,
    console = { log: function (log) { ObjC.NSLog_(log); } };

function _loadScript(name) {
    var script  = document.createElement("script");
    script.type = "text/javascript";
    script.src  = "../JavaScript/" + name + ".js";
    document.head.appendChild(script);
}

// load coffeescript compiler
_loadScript("coffeescript");

// load LESS compiler
_loadScript("less");

// load default styles
var bstyle  = document.createElement("link");
bstyle.rel  = "stylesheet";
bstyle.type = "text/css";
bstyle.href = "base.css";
document.head.appendChild(bstyle);

// load feb.coffee
var fscript  = document.createElement("script");
fscript.type = "text/coffeescript";
fscript.src  = "../JavaScript/feb.coffee";
document.head.appendChild(fscript);

// convert feb/less to text/less
var scripts = document.getElementsByTagName("style");
for (var i in scripts) {
    if (scripts[i].type == "feb/less") scripts[i].type = "text/less";
}

// load scripts in feb/require
var metas = document.getElementsByTagName("meta");
for (var i in metas) {
    var m = metas[i];
    switch (m.name) {
        case "feb/require":
            var values = m.content.split(" ");
            for (var i in values) _loadScript(values[i]);
            break;
        default:
            break;
    }
}
