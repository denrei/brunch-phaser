FONT = 'Futura,system-ui,sans-serif'

module.exports =

  key: 'menu'

  init: (data) ->
    @highScore = data.score or 0

  create: ->
    sky = @add.image 400, 300, 'sky'
    sky.alpha = 0.25
    @add.text(0, 0, 'ROGUEHACK NOW',
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

    showSmallText('D: Dialog demo', 40, 390)
    showSmallText('N: Player Navigation demo', 40, 420)
    showSmallText('High Score: ' + @highScore, 40, 450)

    startNav = () =>
      @scene.start 'navigation', today: (new Date).toString()
    @input.on 'pointerup', startNav

    #TODO Keyboard presses are broken on itch.io ??
    @input.keyboard.once 'keydown_D', () =>
      @scene.start 'demo_dialog', today: (new Date).toString(), this
    @input.keyboard.once 'keydown_N', startNav

  extend:
    highScore: 0