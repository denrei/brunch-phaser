Event = window.roguehack.Event
Linear = Phaser.Math.Interpolation.Linear

class Camera

  constructor: (@cam, @player, @CameraFollowLerp=0.02) ->
    @inputChanged = new Event

  update: (dt) ->
    camScrollTarget =
      x: @player.getX() - @cam.width *0.5
      y: @player.getY() - @cam.height *0.5

    scrollX = Math.floor(Linear([@cam.scrollX, camScrollTarget.x], @CameraFollowLerp))
    scrollY = Math.floor(Linear([@cam.scrollY, camScrollTarget.y], @CameraFollowLerp))
    @cam.setScroll(scrollX, scrollY)

module.exports = Camera
