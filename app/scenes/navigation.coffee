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
    @load.tilemapTiledJSON 'map', 'rl_tilemap.json'
    @load.image 'tiles', 'rl_tiles.png'

  create: ->
    # Create background
    bgClouds = @add.tileSprite 0, -20, 5000, 320, 'bg_clouds'
    bgClouds.setScale 1.1
    # Create tile map
    map = @make.tilemap(key: 'map')
    tileset = map.addTilesetImage('rl_tileset', 'tiles', 32, 32) # First Argument is the name of Tileset referenced in Tilemap JSON

    # Define NPC Objects
    ton = {}
    # Loop Through Tile Map Object Layer. If Object Name matches (NPC) Game Object,
    # Assign TileMap Coordinates to Game Object Position
    for e, i in map.objects[0].objects
      if e.name == 'ton'
        ton.x = e.x
        ton.y = e.y

    #Create layer(s) w/ collision tiles
    layer = map.createStaticLayer(0, tileset, 0, 32)
    layer2 = map.createStaticLayer(1, tileset, 0, 32)
    layer.setCollisionByProperty({ collides: true });
    layer2.setCollisionByProperty({ collides: true });
    @matter.world.convertTilemapLayer(layer);
    @matter.world.convertTilemapLayer(layer2);

    @matter.world.setBounds map.widthInPixels, map.heightInPixels
    # @matter.world.createDebugGraphic()
    # @matter.world.drawDebug = true

    @cameras.main.setBounds 0, 0, map.widthInPixels, map.heightInPixels
    @cameras.main.setScroll 95, 100

    @playerSprite = @matter.add.sprite 256, 256, 'playerAnim'
#    @playerSprite.play('idle-fwd');
    @navLocation =
      x: @playerSprite.x
      y: @playerSprite.y

    createAnim = (name, start, end ) =>
      @anims.create
        key: name
        frames: @anims.generateFrameNumbers('playerAnim', { start: start, end: end })
        frameRate: 8
        repeat: -1

    createAnim 'idle_front', 2,2
    createAnim 'idle_back', 0, 0
    createAnim 'walk_back', 3, 6
    createAnim 'walk_fwd', 8, 11
    createAnim 'walk_left', 13, 16
    @playerSprite.anims.play('idle_front');

    # Create NPCs
    @tonSprite = @matter.add.image ton.x, ton.y, 'ton'
    @tonSprite.body.isStatic = true

    # Create Top Level TileMap Layer (for objects that overlap NPCs)
    layer3 = map.createStaticLayer(2, tileset, 0, 32)
    layer3.setCollisionByProperty({ collides: true })
    @matter.world.convertTilemapLayer(layer3)

    # Input
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
    xDistance = (@navLocation.x - @playerSprite.x) * @MoveSpeed * dt
    yDistance = (@navLocation.y - @playerSprite.y) * @MoveSpeed * dt
    @playerSprite.x += xDistance
    @playerSprite.y += yDistance

    if Math.abs(xDistance.toFixed(2)) < 0.05 && Math.abs(yDistance.toFixed(2)) < 0.05
      @playerSprite.anims.play("idle_front")

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

  # directionalMove: ->
  #   return
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
