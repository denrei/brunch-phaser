RogueHack = require('lib/roguehack')
roguehack = new RogueHack
window.game = new Phaser.Game
  width: roguehack.CANVAS_WIDTH_INITIAL
  height: roguehack.CANVAS_HEIGHT_INITIAL
  zoom: roguehack.getViewportZoom()
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
    require('scenes/menu')
    require('scenes/navigation')
  ]
