function FebHandleEvent(data) {

}

(function () {

var feb = window.feb = { version: 1.0 }, currentId = 0, eventHandlers = {};

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

})();

document.addEventListener("DOMContentLoaded", function () {
    for (var key in window) {
        document.write(key + "<br>");
    }
});