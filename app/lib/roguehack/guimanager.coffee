class GUIManager

  stickyText: null

  log: (message) ->
    if window.roguehack.Constant.DEBUG
      console.log message

  getViewportZoom: ->
    zoom = 1
    width = window.roguehack.Constant.CANVAS_WIDTH_NATIVE

    while width < window.innerWidth
      width *= 2
      zoom *= 2

    return zoom / 2

  displayGameMessage: (phaserInstance, message) ->
    if @stickyText
      @stickyText.destroy()
    @log message
    @stickyText = phaserInstance.add.text(16, 16, message,
      fontSize: '14px'
      padding:
        x: 10
        y: 5
      backgroundColor: '#eee'
      fill: '#000')
    @stickyText.setScrollFactor 0

module.exports = GUIManager
