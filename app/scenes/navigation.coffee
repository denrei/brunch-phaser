RogueHack = require('lib/roguehack')
roguehack = new RogueHack
module.exports =

  key: 'navigation'

  init: (data) ->
    console.log 'init', data, this

    @navLocation =
      x: 0
      y: 0

  preload: ->
    @load.image 'tile', 'street_X_YTiling.png'
    @load.image 'girly', 'girly.gif'
    @load.image 'bg_clouds', 'bg_clouds.png'
    @load.image 'tilex', 'street_xTiling.png'
    @load.image 'tiley', 'street_yTiling.png'
    @load.image 'wall1', 'exteriorWall_southFacing_fullCollision_variant01.png'
    @load.image 'wall', 'exteriorWall_southFacing_fullCollision.png'
    @load.tilemapTiledJSON 'map', 'rl_tilemap_8x8.json'
    @load.image 'tiles', 'rl_tiles.png'
    return this


  create: ->
    #first create background
    bgClouds = @add.tileSprite 0, -20, 5000, 320, 'bg_clouds'
    bgClouds.setScale 1.1
    #second create tile map
    map = @make.tilemap(key: 'map')
    tileset = map.addTilesetImage('rl_tileset', 'tiles', 32, 32) # First Argument is the name of Tileset referenced in Tilemap JSON
    #give it a layer w/ collision tiles
    layer = map.createStaticLayer(0, tileset, 0, 32)
    layer.setCollisionByProperty({ collides: true });

    @matter.world.convertTilemapLayer(layer);

    @matter.world.setBounds map.widthInPixels, map.heightInPixels

    # @matter.world.createDebugGraphic()
    # @matter.world.drawDebug = true

    @cameras.main.setBounds 0, 0, map.widthInPixels, map.heightInPixels
    @cameras.main.setScroll 95, 100

    @playerSprite = @matter.add.image 64, 196, 'girly'
    @playerSprite.setScale 0.1

    @keys = @input.keyboard.createCursorKeys()

    @input.on 'pointerdown', (pointer) =>
      cam = pointer.camera
      @navLocation =
        x: Math.floor(pointer.x + cam.scrollX)
        y: Math.floor(pointer.y + cam.scrollY)
      console.log @navLocation
      # tween = this.tweens.add({
      #   targets: @playerSprite,
      #   x: 600,
      #   ease: 'Power1',
      #   duration: 3000
      # });

  update: (timestep, dt) ->
    # if @keys.up.isDown
    #   @matterPlayer.setVelocityY(-5)
    # if @keys.down.isDown
    #   @matterPlayer.setVelocityY(5)
    # if @keys.left.isDown
    #   @matterPlayer.setVelocityX(-5)
    # if @keys.right.isDown
    #   @matterPlayer.setVelocityX(5)

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
    scrollX = Math.floor(interp([cam.scrollX, camScrollTarget.x], @CameraFollowLerp))
    scrollY = Math.floor(interp([cam.scrollY, camScrollTarget.y], @CameraFollowLerp))
    cam.setScroll(scrollX, scrollY)

  extend:
    MaxSpeed: 100
    MoveLerp: 0.00125
    CameraFollowLerp: 0.02

    quit: ->
      @scene.start 'menu', score: @score
