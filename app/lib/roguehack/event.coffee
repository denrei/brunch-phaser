class Event

  constructor: ->
    @listeners = {}
    @uniqueId = 0

  add: (listener) ->
    @listeners[++@uniqueId] = listener
    length = Object.keys(@listeners).length
    if length > 8
      console.trace "Thats a lotta listeners up in here (#{ length }).. are you fuckin' up?"

    #Return a callback which allows the new listener to be removed from this event
    #also, @uniqueId gets passed by value and not by reference... right??
    listenerRemover = (id) =>
      ( => delete @listeners[id])
    return listenerRemover(@uniqueId)


  #Pass all arguments and invoke all listeners previously registered via the 'add' function.
  call: (args...) ->
    l(args...) for k,l of @listeners

module.exports = Event
