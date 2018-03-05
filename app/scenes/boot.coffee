module.exports =

  key: 'boot'

  preload: ->
    @load.image 'sky', 'space3.png'
    @load.image 'logo', 'phaser3-logo.png'
    @load.image 'red', 'red.png'
    @load.image 'console', 'cmdprompt.gif'
    @load.on 'progress', @onLoadProgress, this
    @load.on 'complete', @onLoadComplete, this
    @createProgressBar()
    return

  create: ->

    #Does this work??
#    window.onresize = () =>
#      window.game.renderer.resize(window.innerWidth, window.innerHeight, 1.0);
#      console.log "Resized #{ window.innerWidth } - #{ window.innerHeight }"

    @scene.start 'menu'
    return

  extend:

    progressBar: null

    progressBarRectangle: null

    createProgressBar: ->
      main = @cameras.main
      @progressBarRectangle = new (Phaser.Geom.Rectangle)(0, 0, 0.5 * main.width, 50)
      Phaser.Geom.Rectangle.CenterOn @progressBarRectangle, 0.5 * main.width, 0.5 * main.height
      @progressBar = @add.graphics()
      return

    onLoadComplete: (loader) ->
      console.log 'onLoadComplete', loader
      @progressBar.destroy()
      return

    onLoadProgress: (progress) ->
      rect = @progressBarRectangle
      color = if @load.failed.size > 0 then 0xff2200 else 0xffffff
      @progressBar.clear().fillStyle(0x222222).fillRect(rect.x, rect.y, rect.width, rect.height).fillStyle(color).fillRect rect.x, rect.y, progress * rect.width, rect.height
      console.log 'progress', progress
      return
