feb = window.feb = version: 1.0

currentId = 0
eventHandlers = {}

feb._handleEvent = (data) ->

    ary = JSON.parse data
    feb._fireEvent ary[0], ary[1]

feb._fireEvent = (name, object) ->

    return unless eventHandlers[name]
    handler[1](object) for handler in eventHandlers[name]

feb.log = (msg) ->

    ObjC.NSLog_ msg
    
feb.on = (name, callback) ->

    myId = currentId++
    eventHandlers[name] ||= []
    eventHandlers[name].push [myId, callback]
    myId

feb.sendMessage = (name, object) ->

    json = JSON.stringify [name, object]
    ObjC.sendJSON_ json

feb.deleteHandler = (id, name) ->

    return false unless eventHandlers[name]
    final = []
    didIt = false;
    
    for o in eventHandlers[name]
        if o[0] != id
            final.push o
        else
            didIt = true
    eventHandlers[name] = final
    didIt

# run a coffeescript
runScript = (thisScript) ->

    if thisScript.type is "text/febcs"
        try
            eval CoffeeScript.compile thisScript.innerText
        catch error
            feb.log "could not compile coffeescript: " + error.message
            document.body.innerText = "CoffeeScript error: " + error.message
            
    else if thisScript.type is "text/febjs"
        jsScript = document.createElement "script"
        jsScript.innerText = thisScript.innerText
        jsScript.type = "text/javascript"
        document.head.appendChild jsScript

# run all text/feb scripts
runScript(script) for script in document.getElementsByTagName "script"

ObjC.febLoaded()
