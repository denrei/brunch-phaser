FONT = 'Futura,system-ui,sans-serif'

module.exports =

  key: 'menu'

  init: (data) ->
    @highScore = data.score or 0

  create: ->
    sky = @add.image 400, 300, 'sky'
    sky.alpha = 0.25
    @add.text(0, 0, 'ROGUEHACK/ONE SHOT',
      fill: 'white'
      fontFamily: FONT
      fontSize: 48)
      .setOrigin(0.0)
      .setShadow 0, 1, '#62F6FF', 10

    showSmallText = (message, x, y) =>
      @add.text(x, y, message,
        fill: '#FED141'
        fontFamily: FONT
        fontSize: 24)
        .setOrigin(0)
        .setShadow 0, 1, 'black', 5

    showSmallText('A: Alibi simulator', 40, 390)
    showSmallText('N: Player Navigation demo', 40, 420)
    showSmallText('High Score: ' + @highScore, 40, 450)

    startScene = (sceneKey) =>
      @scene.start sceneKey, today: (new Date).toString(), this

    @input.keyboard.once 'keydown_A', =>
      startScene('alibisimulator')

    @input.keyboard.once 'keydown_N', =>
      startScene('navigation')

    @input.on 'pointerup', =>
      startScene('navigation')

  extend:
    highScore: 0













