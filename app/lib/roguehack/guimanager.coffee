class GUIManager

  stickyText: null

  log: (message) ->
    if @DEBUG
      console.log message

  getViewportZoom: ->
    return 1.5

  displayGameMessage: (phaserInstance, message) ->
    if @stickyText
      @stickyText.destroy()
    @log message
    @stickyText = phaserInstance.add.text(16, 16, message,
      fontSize: '18px'
      padding:
        x: 10
        y: 5
      backgroundColor: '#ffffff'
      fill: '#000000')
    @stickyText.setScrollFactor 0

module.exports = GUIManager
