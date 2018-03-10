class GUIManager

  MESSAGE_FONT_SIZE: 14
  MESSAGE_FONT_FAMILY: window.roguehack.Constant.FONT

  gameMessage: null
  clickableOptions: []
  clickableOptionThumbnails: []
  messageOffsetX: 16

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

  getViewportZoom: ->
    zoom = 1
    width = window.roguehack.Constant.CANVAS_WIDTH_NATIVE
    while width < window.innerWidth
      width *= 2
      zoom *= 2
    return zoom / 2

  displayGameMessage: (phaserInstance, message) ->
    @_clearGameMessage()

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
      wordWrap:
        width: window.game.canvas.width - (2 * @messageOffsetX)
        useAdvancedWrap: true
    )
    @gameMessage.setOrigin(0.0).setScrollFactor(0)

  displayClickableDialogOptions: (phaserInstance, preamble, options) ->
    @_clearClickableDialogOptions()
    @displayGameMessage(phaserInstance, preamble)
    i = 1
    options.reverse()
    offsety_each = 30
    for option in options
      callback = =>
        @_clearGameMessage()
        @_clearClickableDialogOptions()
        optionCallback = window.roguehack.Constant.NULL_CALLBACK
        if option.callback
          optionCallback = option.callback
        optionCallback()

      offsetx = @messageOffsetX
      offsety = phaserInstance.sys.canvas.height - (offsety_each * i)
      i += 1
      clickableOption = phaserInstance.add.text(
        offsetx
        offsety
        '> ' + option.message
        fontFamily: @MESSAGE_FONT_FAMILY
        fontSize: @MESSAGE_FONT_SIZE + 'px'
        padding:
          x: 10
          y: 5
        backgroundColor: '#eee'
        fill: '#000'
      )
      clickableOption.setOrigin(0).setScrollFactor(0).setInteractive()
      clickableOption.on('pointerdown', callback)
      @clickableOptions.push(clickableOption)

      if option.thumbnail
        thumbnail = phaserInstance.add.image(
          offsetx + 10
          offsety
          option.thumbnail
        )
        thumbnail.setOrigin(0).setScrollFactor(0).setInteractive()
        thumbnail.on('pointerdown', callback)
        @clickableOptionThumbnails.push(thumbnail)



module.exports = GUIManager
