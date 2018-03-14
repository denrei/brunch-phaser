roguehack = new window.roguehack.GUIManager

module.exports =

  key: 'menu'

  create: ->
    sky = @add.image 400, 250, 'sky'
    # sky.alpha = 0.25

    offsetx = 10

    # @add.text(offsetx, 10, 'ONE SHOT',
    #   fill: 'white'
    #   fontFamily: window.roguehack.Constant.FONT
    #   fontSize: 48)
    #   .setOrigin(0.0)
    #   .setShadow 0, 1, '#62F6FF', 10

    showSmallText = (message, x, y) =>
      @add.text(x, y, message,
        fill: '#FED141'
        fontFamily: window.roguehack.Constant.FONT
        fontSize: 18)
        .setOrigin(0)
        .setShadow 0, 1, 'black', 5

    # showSmallText('Tap to begin', offsetx, @sys.game.canvas.height  - 70)

    startScene = (sceneKey) =>
      @scene.start sceneKey, today: (new Date).toString(), this

    @input.keyboard.once 'keydown_N', =>
      startScene('navigation')

    @input.on 'pointerdown', =>
      startScene('navigation')
