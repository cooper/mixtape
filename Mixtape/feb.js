function FebHandleEvent(data) {

}

(function () {

var feb = window.feb = { version: 1.0 };

feb.on = function (name, callback) {

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