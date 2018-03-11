@navLocation = {} # Globalize @navLocation so that it can be refernced during Create() I'm sorryyyyy!

module.exports =

  key: 'navigation'

  init: (data) ->
    console.log 'init', data, this
    @navLocation = new Phaser.Geom.Point()

  preload: ->
    @load.image 'tile', 'street_X_YTiling.png'
    @load.spritesheet('playerAnim', 'character/jen-spritesheet.png', { frameWidth: 12, frameHeight: 25, endFrame: 18 });

    @load.image window.roguehack.Constant.ID_NPC_CHIEF, 'character/megaman.png'
    @load.image window.roguehack.Constant.ID_NPC_DABYL, 'character/Dabyl-placeholder.png'
    @load.image window.roguehack.Constant.ID_NPC_IVIKA, 'character/Ivika-placeholder.png'
    @load.image window.roguehack.Constant.ID_NPC_SIVAN, 'character/Sivan-placeholder.png'
    @load.image window.roguehack.Constant.ID_NPC_TON, 'character/Ton-placeholder.png'
    @load.image window.roguehack.Constant.ID_NPC_VERA, 'character/Vera-placeholder.png'

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

    @playerSprite = @matter.add.sprite 100, 200, 'playerAnim'
    radius_playerCollider = 10
    @playerSprite.setCircle(radius_playerCollider)
    # Set Initial Destination to Player Spawn Point
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

    # Define NPC Objects
    alibiManager = new window.roguehack.AlibiManager(this, 5)
    npc_chief = {}
    npc_dabyl = {}
    npc_ivika = {}
    npc_sivan = {}
    npc_ton = {}
    npc_vera = {}
    # Loop Through Tile Map Object Layer. If Object Name matches (NPC) Game Object,
    # Assign TileMap Coordinates to Game Object Position
    for e, i in map.objects[0].objects
      if e.name == window.roguehack.Constant.ID_NPC_CHIEF
        npc_chief.x = e.x
        npc_chief.y = e.y
      else if e.name == window.roguehack.Constant.ID_NPC_DABYL
        npc_dabyl.x = e.x
        npc_dabyl.y = e.y
      else if e.name == window.roguehack.Constant.ID_NPC_IVIKA
        npc_ivika.x = e.x
        npc_ivika.y = e.y
      else if e.name == window.roguehack.Constant.ID_NPC_SIVAN
        npc_sivan.x = e.x
        npc_sivan.y = e.y
      else if e.name == window.roguehack.Constant.ID_NPC_TON
        npc_ton.x = e.x
        npc_ton.y = e.y
      else if e.name == window.roguehack.Constant.ID_NPC_VERA
        npc_vera.x = e.x
        npc_vera.y = e.y
    createNpcSprite = (image_id, alibiManager, x, y) =>
      npcSprite = @matter.add.image x, y, image_id
      npcSprite.body.isStatic = true
      npcSprite.name = image_id
      if alibiManager
        alibiManager.assignAlibi(npcSprite.name)
    createNpcSprite(window.roguehack.Constant.ID_NPC_CHIEF, null, npc_chief.x, npc_chief.y)
    createNpcSprite(window.roguehack.Constant.ID_NPC_DABYL, alibiManager, npc_dabyl.x, npc_dabyl.y)
    createNpcSprite(window.roguehack.Constant.ID_NPC_IVIKA, alibiManager, npc_ivika.x, npc_ivika.y)
    createNpcSprite(window.roguehack.Constant.ID_NPC_SIVAN, alibiManager, npc_sivan.x, npc_sivan.y)
    createNpcSprite(window.roguehack.Constant.ID_NPC_TON, alibiManager, npc_ton.x, npc_ton.y)
    createNpcSprite(window.roguehack.Constant.ID_NPC_VERA, alibiManager, npc_vera.x, npc_vera.y)


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

    # Player Idle Animation and Stop Movement if Collision with Wall, etc.
    @matter.world.on 'collisionstart', (event, bodyA, bodyB) ->
      console.log("Collide")
      # console.log("bodyA:")
      # console.log(bodyA.gameObject)
      # console.log("bodyB:")
      # console.log(bodyB.gameObject)

      # Detect if body has animations. Sometimes Player is bodyB.
      # Other times player is Body A. (I dont't know why)
      if bodyB.gameObject.anims
        bodyB.gameObject.anims.play("idle_front")
        @navLocation =
          x: bodyB.gameObject.x
          y: bodyB.gameObject.y
        return
      bodyA.gameObject.anims.play("idle_front")
      @navLocation =
        x: bodyA.gameObject.x
        y: bodyA.gameObject.y
      if bodyB.gameObject.name == window.roguehack.Constant.ID_NPC_CHIEF
        alibiManager.handleDialogWithChief(bodyB)
        return
      alibiManager.displayAlibiForBody(bodyB)


  update: (timestep, dt) ->
    speed = 0.05
    xDistance = Phaser.Math.Clamp((@navLocation.x - @playerSprite.x) * 99999, -speed, speed) * dt
    yDistance = Phaser.Math.Clamp((@navLocation.y - @playerSprite.y) * 99999, -speed, speed) * dt
    @playerSprite.x += xDistance
    @playerSprite.y += yDistance

    # If Player Distance to Destination gets VERYYYY short...
    radius_destination = 0.05
    if Math.abs(xDistance.toFixed(2)) < radius_destination && Math.abs(yDistance.toFixed(2)) < radius_destination
      @playerSprite.anims.play("idle_front") # Play Idle Animation
      @navLocation =
        x: @playerSprite.x
        y: @playerSprite.y

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
