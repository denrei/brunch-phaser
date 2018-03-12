class Player

  constructor: (playerSprite, input, anims) ->
    @playerPhysics = new PlayerPhysics playerSprite, input.getInputEvent()
    @playerAnimation = new PlayerAnimation playerSprite, @playerPhysics, anims

  update: (dt) ->
    @playerPhysics.update(dt)

  render: (debug) ->
    @pixelArtSprite.render debug

  getX: ->
    return @playerPhysics.getX()

  getY: ->
    return @playerPhysics.getY()


class PlayerPhysics

  constructor: (@playerSprite, inputEvent) ->
    @navLocation = new Phaser.Geom.Point(@playerSprite.x, @playerSprite.y)
    inputEvent.add (args...) => @handleInputChanged(args...)
    @playerSprite.setCircle(10)
    @physicsChanged = new window.roguehack.Event

  getPlayerPhysicsEvent: =>
    return @physicsChanged
  getNavLocation: ->
    return @navLocation
  getX: ->
    return @playerSprite.x
  getY: ->
    return @playerSprite.y

  handleInputChanged: ({screen, world}) ->
    @navLocation = world
    @physicsChanged.call()

  update: (dt) ->
    speed = 0.05
    xDistance = Phaser.Math.Clamp((@navLocation.x - @playerSprite.x) * 99999, -speed, speed) * dt
    yDistance = Phaser.Math.Clamp((@navLocation.y - @playerSprite.y) * 99999, -speed, speed) * dt

    @playerSprite.setVelocityX(xDistance);
    @playerSprite.setVelocityY(yDistance);
#    @playerSprite.x += xDistance
#    @playerSprite.y += yDistance

    # If Player Distance to Destination gets VERYYYY short...
    radius_destination = 0.05
    if Math.abs(xDistance.toFixed(2)) < radius_destination && Math.abs(yDistance.toFixed(2)) < radius_destination
      @playerSprite.anims.play("idle_front") # Play Idle Animation
      @navLocation =
        x: @playerSprite.x
        y: @playerSprite.y
    @physicsChanged.call(dt)

class PlayerAnimation

  constructor: (@playerSprite, @playerPhysics, anims) ->
    @createAnimations anims
    @playerPhysics.getPlayerPhysicsEvent().add (dt) =>
      if not dt?
        @updateAnimationState()
    @animStateRules =      ## use body.facing ???
      "action": => not playerPhysics.isOnFloor
      "walk": => input.rightInput or input.leftInput
      "idle": => true

  createAnimations: (anims) ->
    animationList =
      'idle_front': [2, 2]
      'idle_back': [0, 0]
      'walk_back': [3, 6]
      'walk_fwd': [8, 11]
      'walk_left': [13, 16]
    for name, start_end of animationList
      anims.create
        key: name
        frames: anims.generateFrameNumbers('playerAnim', {start: start_end[0], end: start_end[1]})
        frameRate: 8
        repeat: -1

  updateAnimationState: ->
    navLocation = @playerPhysics.getNavLocation()

    vert = (navLocation.y - @playerSprite.y)
    hori = (navLocation.x - @playerSprite.x)
    if vert * vert > hori * hori
      if navLocation.y < @playerSprite.y
        @playerSprite.anims.play('walk_back')
      else
        @playerSprite.anims.play('walk_fwd')
    else
      if navLocation.x < @playerSprite.x
        @playerSprite.scaleX = -1
        @playerSprite.anims.play('walk_left')
      else
        @playerSprite.scaleX = 1
        @playerSprite.anims.play('walk_left')

#    for animName, requirement of @animStateRules
#      if requirement()
#        facingRight = if input.leftInput then -1 else 1
#        pixelArtSprite.play animName, facingRight
#        return

module.exports = Player
