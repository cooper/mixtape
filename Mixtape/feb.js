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

})();

document.addEventListener("DOMContentLoaded", function () {
    for (var key in window) {
        document.write(key + "<br>");
    }
});