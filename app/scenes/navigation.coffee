RogueHack = require('lib/roguehack').RogueHack
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

    @load.tilemapTiledJSON('map', 'rl_tilemap_01_tileSetEmbedded.json');
    @load.image('rl_tilemap_01', 'RL_tiles_01.png');

  create: ->

    map = @make.tilemap(key: 'map')
    tileset = map.addTilesetImage('rl_tilemap_01')

    @matter.world.setBounds map.widthInPixels, map.heightInPixels

    @matter.world.createDebugGraphic()
    @matter.world.drawDebug = true

    @cameras.main.setBounds 0, 0, map.widthInPixels, map.heightInPixels
    @cameras.main.setScroll 95, 100

    RogueHack.testAlibiMessages()

    @playerSprite = @add.image 0, 0, 'red'

    @matterPlayer = @matter.add.image 256, 256, 'red'

    @keys = @input.keyboard.createCursorKeys()

    @input.on 'pointerdown', (pointer) =>
      cam = pointer.camera
      @navLocation =
        x: pointer.x + cam.scrollX
        y: pointer.y + cam.scrollY
      console.log @navLocation

  update: (timestep, dt) ->
    if @keys.up.isDown
      @matterPlayer.setVelocityY(-5)
    if @keys.down.isDown
      @matterPlayer.setVelocityY(5)
    if @keys.left.isDown
      @matterPlayer.setVelocityX(-5)
    if @keys.right.isDown
      @matterPlayer.setVelocityX(5)

    #update player position
    clampSpeed = (d, max) =>
      return d

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
