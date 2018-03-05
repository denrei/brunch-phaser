RogueHack =
  displayMessage: (message) ->
    console.log('(game message) ' + message)

module.exports =

  key: 'navigation'

  init: (data) ->
    console.log 'init', data, this

    @navLocation =
      x: 0
      y: 0

  preload: ->
    @load.image 'tile', 'street_X_YTiling.png'
    @load.image 'tilex', 'street_xTiling.png'
    @load.image 'tiley', 'street_yTiling.png'
    @load.image 'wall1', 'exteriorWall_southFacing_fullCollision_variant01.png'
    @load.image 'wall', 'exteriorWall_southFacing_fullCollision.png'

  create: ->
    @add.image 0,0, 'tile'
    @add.image -128,0, 'tile'
    @add.image 0, -128, 'tile'
    @add.image -128, -128, 'tile'

    @add.image 128,0, 'tilex'
    @add.image 256,0, 'tilex'
    @add.image 0,128, 'tiley'
    @add.image 0,256, 'tiley'

    @add.image 384,0, 'tile'
    @add.image 0,384, 'tile'

    @add.image 128, -128, 'wall'
    @add.image 256, -128, 'wall1'
    @add.image 384, -128, 'wall'
    @add.image 128*4, -128, 'wall'

    RogueHack.displayMessage('Character: Hello world? That sounds familiar.')

    @playerSprite = @add.image 0, 0, 'red'

    @input.on 'pointerdown', (pointer) =>
      cam = pointer.camera
      @navLocation =
        x: pointer.x + cam.scrollX
        y: pointer.y + cam.scrollY
      console.log @navLocation

  update: (timestep, dt) ->
    #update player position
    clampSpeed = (d, max) =>
      return d
      # return Phaser.Math.Clamp(d, -@MaxSpeed, @MaxSpeed)

    @playerSprite.x += clampSpeed (@navLocation.x - @playerSprite.x) * @MoveLerp * dt
    @playerSprite.y += clampSpeed (@navLocation.y - @playerSprite.y) * @MoveLerp * dt

    cam = @cameras.main
    camScrollTarget =
      x: @playerSprite.x - cam.width *0.5
      y: @playerSprite.y - cam.height *0.5

    Phaser.Time.Clock
    #Follow player
    interp = Phaser.Math.Interpolation.Linear
    scrollX = interp([cam.scrollX, camScrollTarget.x], @CameraFollowLerp)
    scrollY = interp([cam.scrollY, camScrollTarget.y], @CameraFollowLerp)
    cam.setScroll(scrollX, scrollY)

  extend:
    MaxSpeed: 100
    MoveLerp: 0.00125
    CameraFollowLerp: 0.02

    quit: ->
      @scene.start 'menu', score: @score
