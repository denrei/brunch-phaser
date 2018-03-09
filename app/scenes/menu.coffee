RogueHack = require('lib/roguehack')
roguehack = new RogueHack

module.exports =

  key: 'menu'

  init: (data) ->
    @highScore = data.score or 0

  create: ->

    @sys.game.canvas.width


    sky = @add.image 400, 300, 'sky'
    sky.alpha = 0.25

    offsetx = 10

    @add.text(offsetx, 10, 'ONE SHOT',
      fill: 'white'
      fontFamily: roguehack.FONT
      fontSize: 48)
      .setOrigin(0.0)
      .setShadow 0, 1, '#62F6FF', 10

    showSmallText = (message, x, y) =>
      @add.text(x, y, message,
        fill: '#FED141'
        fontFamily: roguehack.FONT
        fontSize: 18)
        .setOrigin(0)
        .setShadow 0, 1, 'black', 5

    showSmallText('Tap to begin', offsetx, @sys.game.canvas.height  - 90)
    showSmallText('A: Alibi simulator', offsetx, @sys.game.canvas.height - 70)
    showSmallText('N: Player Navigation demo', offsetx, @sys.game.canvas.height - 50)
    showSmallText('High Score: ' + @highScore, offsetx, @sys.game.canvas.height - 30)

    startScene = (sceneKey) =>
      @scene.start sceneKey, today: (new Date).toString(), this

    @input.keyboard.once 'keydown_A', =>
      startScene('alibisimulator')

    @input.keyboard.once 'keydown_N', =>
      startScene('navigation')

    @input.on 'pointerdown', =>
      startScene('navigation')

  extend:
    highScore: 0













