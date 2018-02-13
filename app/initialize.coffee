config =

  type: Phaser.AUTO

  width: 800

  height: 600

  physics:
    default: 'arcade'
    arcade: gravity: y: 180

  scene:

    preload: ->
      @load.setPath 'assets/'
      @load.image 'sky', 'space3.png'
      @load.image 'logo', 'phaser3-logo.png'
      @load.image 'red', 'red.png'
      return

    create: ->
      sky = @add.image 400, 300, 'sky'
      sky.alpha = 0.5
      particles = @add.particles 'red'
      emitter = particles.createEmitter
        speed: 100
        scale:
          start: 1
          end: 0
        blendMode: 'ADD'
      logo = @physics.add.image 400, 100, 'logo'
      logo.setVelocity 100, 200
      logo.setBounce 1, 1
      logo.setCollideWorldBounds true
      emitter.startFollow logo
      return

window.game = new Phaser.Game config
