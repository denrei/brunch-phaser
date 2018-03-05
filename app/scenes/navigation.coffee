module.exports =

  key: 'navigation'

  init: (data) ->
    console.log 'init', data, this

    @navLocation =
      x: 0
      y: 0

    return

  create: ->
    background = @add.image 0,0, 'sky'
    @playerSprite = @add.image 0, 0, 'red'

    @input.on 'pointerdown', (pointer) =>
      cam = pointer.camera
      @navLocation =
        x: pointer.x + cam.scrollX
        y: pointer.y + cam.scrollY
      console.log @navLocation

  update: ->
    #update player position
    clampSpeed = (d, max) =>
      return Phaser.Math.Clamp(d, -@MaxSpeed, @MaxSpeed)

    @playerSprite.x += clampSpeed (@navLocation.x - @playerSprite.x) * @MoveLerp
    @playerSprite.y += clampSpeed (@navLocation.y - @playerSprite.y) * @MoveLerp

    #Follow player
    @cameras.main.setScroll(@playerSprite.x - @cameras.main.width *0.5, @playerSprite.y - @cameras.main.height *0.5)

  extend:

    MaxSpeed: 3
    MoveLerp: 0.05

    quit: ->
      @scene.start 'menu', score: @score
