class GUIManager

  MESSAGE_FONT_SIZE: 14
  MESSAGE_FONT_FAMILY: window.roguehack.Constant.FONT

  gameMessage: null
  clickableOptions: []
  messageOffsetX: 16

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
    if @gameMessage
      @gameMessage.destroy()
    @log message
    @gameMessage = phaserInstance.add.text(
      @messageOffsetX
      @messageOffsetX
      message
      fontFamily: @MESSAGE_FONT_FAMILY
      fontSize: @MESSAGE_FONT_SIZE + 'px'
      padding:
        x: 10
        y: 5
      backgroundColor: '#eee'
      fill: '#000'
    )
    @gameMessage.setOrigin(0.0)
    @gameMessage.setScrollFactor(0)

  _destroyClickableOptions: ->
    for clickableOption in @clickableOptions
      clickableOption.destroy()
    @clickableOptions = []

  displayClickableDialogOptions: (phaserInstance, options) ->
    i = 1
    options.reverse()
    for option in options
      message = option.message

      offsetx = @messageOffsetX
      offsety = phaserInstance.sys.canvas.height - (30 * i)
      i += 1

      clickableOption = phaserInstance.add.text(
        offsetx
        offsety
        message
        fontFamily: @MESSAGE_FONT_FAMILY
        fontSize: @MESSAGE_FONT_SIZE + 'px'
        padding:
          x: 10
          y: 5
        backgroundColor: '#eee'
        fill: '#000'
      )
      clickableOption.setOrigin(0).setScrollFactor(0).setInteractive()
      callback = =>
        @_destroyClickableOptions()
        option.callback()

      clickableOption.on('pointerdown', callback)
      @clickableOptions.push(clickableOption)


module.exports = GUIManager
