module.exports =

  init: (data) ->
    console.log 'init', data, this
    return

  preload: ->
    @load.image 'sky', 'space3.png'
    @load.image 'logo', 'phaser3-logo.png'
    @load.image 'red', 'red.png'
    @progressBar = @add.graphics 0, 0
    @load.on 'progress', @onLoadProgress, this
    @load.on 'complete', @onLoadComplete, this
    return

  create: ->
    sky = @add.image 400, 300, 'sky'
    sky.alpha = 0.5
    particles = @add.particles 'red'
    emitter = particles.createEmitter(
      speed: 100
      scale:
        start: 1
        end: 0
      blendMode: 'ADD')
    logo = @physics.add.image 400, 100, 'logo'
    logo.setVelocity 100, 200
    logo.setBounce 1, 1
    logo.setCollideWorldBounds true
    emitter.startFollow logo
    return

  extend:

    progressBar: null

    onLoadComplete: ->
      console.log 'onLoadComplete'
      @progressBar.destroy()
      return

    onLoadProgress: (progress) ->
      @progressBar
        .clear()
        .fillStyle 0xffffff, 0.75
        .fillRect 0, 0, 800 * progress, 50
      console.log 'progress', progress
      return
