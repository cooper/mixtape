(function () {

var feb = window.feb = { version: 1.0 }, currentId = 0, eventHandlers = {};

feb._handleEvent = function (data) {
    var ary = JSON.parse(data);
    feb._fireEvent(ary[0], ary[1]);
};

feb._fireEvent = function (name, object) {
    if (!eventHandlers[name]) return;
    for (var o in eventHandlers[name]) o[1](callback);
};

feb.log = function (msg) {
    ObjC.NSLog_(msg);
};

feb.on = function (name, callback) {
    var myId = currentId++;
    if (!eventHandlers[name]) eventHandlers[name] = [];
    eventHandlers[name].push([myId, callback]);
    return myId;
};

feb.sendMessage = function (name, object) {
    var json = JSON.stringify([name, object]);
    return ObjC.sendJSON_(json);
};

feb.deleteHandler = function (id, name) {
    if (!eventHandlers[name]) return false;
    var final = [];
    var didIt = false;
    for (var o in eventHandlers[name]) {
        if (o[0] != id) {
            final.push(o);
            didIt = true;
        }
    }
    eventHandlers[name] = final;
    return didIt;
};

ObjC.febLoaded();

// load coffeescript
var cscript  = document.createElement("script");
cscript.type = "text/javascript";
cscript.src  = "coffeescript.js";

// run a coffeescript
var runScript = function (thisScript) {
    if (thisScript.type != "text/feb") return;
    cscript.addEventListener("load", function () {
        try {
            eval(CoffeeScript.compile(thisScript.innerText));
        }
        catch(error) {
            feb.log("could not compile coffeescript: " + error.message);
        }
    });
};

// run all text/feb scripts
var scripts = document.getElementsByTagName("script");
for (var script in scripts) runScript(scripts[script]);

// inject coffeescript
document.head.appendChild(cscript);

})();