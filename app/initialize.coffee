RogueHack =
  CANVAS_WIDTH_INITIAL: 800
  CANVAS_HEIGHT_INITIAL: 500
  getViewportZoom: ->
    console.log "RogueHack: debug viewport"
    console.log "intended canvas width  : #{ RogueHack.CANVAS_WIDTH_INITIAL }px"
    console.log "intended canvas height : #{ RogueHack.CANVAS_HEIGHT_INITIAL }px"

    aspectRatio_intended = RogueHack.CANVAS_WIDTH_INITIAL / RogueHack.CANVAS_HEIGHT_INITIAL
    console.log "intended aspect ratio  : #{ aspectRatio_intended }"


    zoom = window.innerWidth / RogueHack.CANVAS_WIDTH_INITIAL
    console.log "normally width is limiting"
    aspectRatio_viewport = window.innerWidth / window.innerHeight
    if aspectRatio_viewport > aspectRatio_intended
      console.log "but now height is limiting"
      zoom = window.innerHeight / RogueHack.CANVAS_HEIGHT_INITIAL

    console.log "viewport width         : #{ window.innerWidth }px"
    console.log "viewport height        : #{ window.innerHeight }px"
    console.log "zoom                   : #{ zoom }x"
    return zoom

window.game = new Phaser.Game
  width: RogueHack.CANVAS_WIDTH_INITIAL
  height: RogueHack.CANVAS_HEIGHT_INITIAL
  zoom: RogueHack.getViewportZoom()
  # resolution: 1
  # type: Phaser.AUTO
  # parent: null
  # canvas: null
  # canvasStyle: null
  # seed: null
  title: 'RogueHack'
  url: 'https://github.com/denrei/roguehack'
  version: '0.0.1'
  # input:
  #   keyboard: on
  #   mouse: on
  #   touch: on
  #   gamepad: off
  # disableContextMenu: off
  # banner: off
  banner:
    # hidePhaser: off
    text: 'white'
    background: [
      '#e54661'
      '#ffa644'
      '#998a2f'
      '#2c594f'
      '#002d40'
    ]
  # fps:
  #   min: 10
  #   target: 60
  #   forceSetTimeout: off
  # pixelArt: off
  # transparent: off
  # clearBeforeRender: on
  # backgroundColor: 0x000000
  loader:
    # baseURL: ''
    path: 'assets/'
    maxParallelDownloads: 6
    # crossOrigin: 'anonymous'
    # timeout: 0
  physics:
    default: 'matter'
    matter:
      gravity:
        y: 1
      enableSleep : true

    arcade:
      gravity:
        y: 180
  scene: [
    require('scenes/boot')
    require('scenes/default')
    require('scenes/menu')
    require('scenes/navigation')
  ]
