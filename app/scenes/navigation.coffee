RogueHack = require('lib/roguehack')
roguehack = new RogueHack
module.exports =

  key: 'navigation'

  init: (data) ->
    console.log 'init', data, this

    @navLocation = new Phaser.Geom.Point()

  preload: ->
    @load.image 'tile', 'street_X_YTiling.png'
    @load.spritesheet('playerAnim', 'character/jen-spritesheet.png', { frameWidth: 12, frameHeight: 25, endFrame: 18 });

    @load.image 'ton', 'ton_placeholder.png'
    @load.image 'bg_clouds', 'bg_clouds.png'
    @load.image 'tilex', 'street_xTiling.png'
    @load.image 'tiley', 'street_yTiling.png'
    @load.image 'wall1', 'exteriorWall_southFacing_fullCollision_variant01.png'
    @load.image 'wall', 'exteriorWall_southFacing_fullCollision.png'
    @load.tilemapTiledJSON 'map', 'rl_tilemap_8x8.json'
    @load.image 'tiles', 'rl_tiles.png'

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
    @playerSprite = @matter.add.sprite 256, 256, 'playerAnim'
#    @playerSprite.play('idle-fwd');

    createAnim = (name, start, end ) =>
      @anims.create
        key: name
        frames: @anims.generateFrameNumbers('playerAnim', { start: start, end: end })
        frameRate: 8
        repeat: -1

    createAnim 'walk_back', 3, 6
    createAnim 'walk_fwd', 8, 11
    createAnim 'walk_left', 13, 16
    @playerSprite.anims.play('walk_left');

    @npcSprite01 = @matter.add.image 196, 230, 'ton'
    @npcSprite01.body.isStatic = true

    @keys = @input.keyboard.createCursorKeys()
    @input.on 'pointerdown', (pointer) =>
      cam = pointer.camera
      @navLocation = 
        x: Math.floor(pointer.x + cam.scrollX)
        y: Math.floor(pointer.y + cam.scrollY)
      updateAnimation()

    updateAnimation = =>
      vert = (@navLocation.y - @playerSprite.y)
      hori = (@navLocation.x - @playerSprite.x)
      if vert * vert > hori * hori
        if @navLocation.y < @playerSprite.y
          @playerSprite.anims.play('walk_back')
        else
          @playerSprite.anims.play('walk_fwd')
      else
        if @navLocation.x < @playerSprite.x
          @playerSprite.scaleX = -1
          @playerSprite.anims.play('walk_left')
        else
          @playerSprite.scaleX = 1
          @playerSprite.anims.play('walk_left')

  update: (timestep, dt) ->

    @playerSprite.x += (@navLocation.x - @playerSprite.x) * @MoveSpeed * dt
    @playerSprite.y += (@navLocation.y - @playerSprite.y) * @MoveSpeed * dt

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

  directionalMove: ->
    return
  # if @keys.up.isDown
  #   @matterPlayer.setVelocityY(-5)
  # if @keys.down.isDown
  #   @matterPlayer.setVelocityY(5)
  # if @keys.left.isDown
  #   @matterPlayer.setVelocityX(-5)
  # if @keys.right.isDown
  #   @matterPlayer.setVelocityX(5)

  extend:
    MoveSpeed: 0.001
    CameraFollowLerp: 0.02

    quit: ->
      @scene.start 'menu', score: @score
