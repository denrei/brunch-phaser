Function::property = (prop, desc) ->
  Object.defineProperty @prototype, prop, desc


module.exports = class RogueHack

  CANVAS_WIDTH_INITIAL: 640
  CANVAS_HEIGHT_INITIAL: 640
  DEBUG: true
  PATH_DATA: './data/'

  stickyText: null

  log: (message) ->
    if @DEBUG
      console.log message

  getViewportZoom: ->
    # it appears that itch.io, the eventual production environment, renders the game at 640x640.
    return 1

  displayGameMessage: (phaserReference, message) ->
    if @stickyText
      @stickyText.destroy()
    @stickyText = phaserReference.add.text(16, 16, message,
      fontSize: '18px'
      padding:
        x: 10
        y: 5
      backgroundColor: '#ffffff'
      fill: '#000000')
    @stickyText.setScrollFactor 0
