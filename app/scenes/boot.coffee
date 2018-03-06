RogueHack =
  hasViewportResized: false
  handleResize: ->
    if !RogueHack.hasViewportResized
      RogueHack.hasViewportResized = true
      console.error 'RogueHack: viewport resized! zoom now incorrect. refresh page for correct zoom.'
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

    window.onresize = () =>
      RogueHack.handleResize()

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