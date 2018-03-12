class GUIManager

  MESSAGE_PADDING: 12
  MESSAGE_FONT_SIZE: 16
  MESSAGE_FONT_FAMILY: window.roguehack.Constant.FONT
  MESSAGE_FONT_WEIGHT: 16

  gameMessage: null
  clickableOptions: []
  clickableOptionThumbnails: []
  messageOffsetX: 4
  messageOffsetY: 4

  _clearGameMessage: ->
    @log 'clear game message'
    if @gameMessage
      @gameMessage.destroy()
      @gameMessage = null

  _clearClickableDialogOptions: ->
    @log 'clear clickable dialog options'
    for clickableOption in @clickableOptions
      clickableOption.destroy()
    @clickableOptions = []
    for thumbnail in @clickableOptionThumbnails
      thumbnail.destroy()
    @clickableOptionThumbnails = []

# --------------------------------------------------------------------------------------------------------------------

  log: (message) ->
    if window.roguehack.Constant.DEBUG
      console.log message

  getViewportZoom_NiceRatio: ->
    zoomIncrement = 2
    zoom = 1
    width = window.roguehack.Constant.CANVAS_WIDTH_NATIVE
    while width < window.innerWidth
      width *= zoomIncrement
      zoom *= zoomIncrement
    return zoom / zoomIncrement

  getViewportZoom_Continuous: ->
    zoom = window.innerWidth / window.roguehack.Constant.CANVAS_WIDTH_NATIVE
    if window.innerHeight < (zoom * window.roguehack.Constant.CANVAS_HEIGHT_NATIVE)
      zoom = window.innerHeight / window.roguehack.Constant.CANVAS_HEIGHT_NATIVE
    return zoom.toFixed(1)

  displayGameMessage: (phaserInstance, message) ->
    @_clearGameMessage()

    @log message
    @gameMessage = phaserInstance.add.text(
      @messageOffsetX
      @messageOffsetY
      message
      fontFamily: @MESSAGE_FONT_FAMILY
      fontSize: @MESSAGE_FONT_SIZE + 'px'
      padding:
        x: @MESSAGE_PADDING
        y: @MESSAGE_PADDING
      backgroundColor: '#eee'
      fill: '#000'
      wordWrap:
        width: window.game.canvas.width - (3 * @messageOffsetX)
        useAdvancedWrap: false
    )
    @gameMessage.setOrigin(0.0).setScrollFactor(0)

  displayClickableDialogOptions: (phaserInstance, preamble, options) ->
    @_clearClickableDialogOptions()
    @displayGameMessage(phaserInstance, preamble)
    i = 1
    options.reverse()
    offsety_each = 60
    for option in options
      offsetx = @messageOffsetX
      offsety = phaserInstance.sys.canvas.height - (offsety_each * i)
      i += 1
      @clickableOptions.push(
        phaserInstance.add.text(
          offsetx
          offsety
          '> ' + option.message
          fontFamily: @MESSAGE_FONT_FAMILY
          fontSize: @MESSAGE_FONT_SIZE + 'px'
          padding:
            x: @MESSAGE_PADDING
            y: @MESSAGE_PADDING
          backgroundColor: '#eee'
          fill: '#000'
        ).setOrigin(0).setScrollFactor(0).setInteractive().on('pointerdown', =>
          @_clearGameMessage()
          @_clearClickableDialogOptions()
          option.callback()
        )
      )

      if option.thumbnail
        thumbnail = phaserInstance.add.image(
          offsetx + 10
          offsety + 4
          option.thumbnail
        )
        thumbnail.setOrigin(0).setScrollFactor(0).setInteractive()
        @clickableOptionThumbnails.push(thumbnail)

module.exports = GUIManager
