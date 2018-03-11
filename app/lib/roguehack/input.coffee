Event = window.roguehack.Event

class Input

  constructor: (@input) ->
    @inputChanged = new Event

    @input.on 'pointerdown', (pointer) =>
      cam = pointer.camera
      @inputChanged.call
        'world' :
          x: pointer.x + cam.scrollX
          y: pointer.y + cam.scrollY
        'screen':
          x: pointer.x
          y: pointer.y

  getInputEvent: =>
    return @inputChanged

module.exports = Input
