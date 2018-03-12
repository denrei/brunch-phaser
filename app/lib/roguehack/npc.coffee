Event = window.roguehack.Event

class Npc

  constructor: (@phaser, player, map) ->
    @npcChanged = new Event

    # Define NPC Objects
    alibiManager = new window.roguehack.AlibiManager(@phaser, 5)

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

    npcDefinitions = [
      [window.roguehack.Constant.ID_NPC_CHIEF, npc_chief.x, npc_chief.y, false]
      [window.roguehack.Constant.ID_NPC_DABYL, npc_dabyl.x, npc_dabyl.y, true]
      [window.roguehack.Constant.ID_NPC_IVIKA, npc_ivika.x, npc_ivika.y, true]
      [window.roguehack.Constant.ID_NPC_SIVAN, npc_sivan.x, npc_sivan.y, true]
      [window.roguehack.Constant.ID_NPC_TON, npc_ton.x, npc_ton.y, true]
      [window.roguehack.Constant.ID_NPC_VERA, npc_vera.x, npc_vera.y, true]
    ]

    createTouchedNotifications = (s, alibiFunction) =>
      s.touched = =>
        if s.touching
          return
        s.touching = true
        alibiFunction(null,  npcSprite.name)
      s.untouched = =>
        s.touching = false

    @npcs = []
    for [image_id, x, y, needs_alibai] in npcDefinitions
      npcSprite = @phaser.matter.add.image x, y, image_id
      npcSprite.body.isStatic = true
      npcSprite.name = image_id
      @npcs.push(npcSprite)
      if needs_alibai
        createTouchedNotifications(npcSprite,  alibiManager.displayAlibiForBody)
        alibiManager.assignAlibi(image_id)
      else
        createTouchedNotifications(npcSprite,  alibiManager.handleDialogWithChief)

    player.playerPhysics.getPlayerPhysicsEvent().add => @checkCollisions(player)

  getEvent: =>
    return @npcChanged

  checkCollisions: (player) ->
    collisionDistanceSq = 1250
    for npc in @npcs
      distX = npc.x - player.getX()
      distY = npc.y - player.getY()
      distXSq = distX * distX
      distYSq = distY * distY
      if distXSq < collisionDistanceSq and distYSq < collisionDistanceSq
        npc.touched()
      else
        npc.untouched()


module.exports = Npc
