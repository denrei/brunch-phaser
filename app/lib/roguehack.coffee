secretStuff =
  CANVAS_WIDTH_INITIAL: 800
  CANVAS_HEIGHT_INITIAL: 500

module.exports = class RogueHack

  CANVAS_WIDTH_INITIAL: secretStuff.CANVAS_WIDTH_INITIAL
  CANVAS_HEIGHT_INITIAL: secretStuff.CANVAS_HEIGHT_INITIAL
  KEY_FILE_ALIBI: 'file-alibi'
  PATH_DATA: '../../data/'

  stickyText: null

  getViewportZoom: ->
    console.log "RogueHack: debug viewport"
    console.log "intended canvas width  : #{ secretStuff.CANVAS_WIDTH_INITIAL }px"
    console.log "intended canvas height : #{ secretStuff.CANVAS_HEIGHT_INITIAL }px"

    aspectRatio_intended = secretStuff.CANVAS_WIDTH_INITIAL / secretStuff.CANVAS_HEIGHT_INITIAL
    console.log "intended aspect ratio  : #{ aspectRatio_intended }"

    zoom = window.innerWidth / secretStuff.CANVAS_WIDTH_INITIAL
    console.log "normally width is limiting"
    aspectRatio_viewport = window.innerWidth / window.innerHeight
    if aspectRatio_viewport > aspectRatio_intended
      console.log "but now height is limiting"
      zoom = window.innerHeight / secretStuff.CANVAS_HEIGHT_INITIAL

    console.log "viewport width         : #{ window.innerWidth }px"
    console.log "viewport height        : #{ window.innerHeight }px"
    console.log "zoom                   : #{ zoom }x"
    return zoom

  displayGameMessage: (phaserReference, message) ->
    if this.stickyText
      this.stickyText.destroy()
    this.stickyText = phaserReference.add.text(16, 16, message,
      fontSize: '18px'
      padding:
        x: 10
        y: 5
      backgroundColor: '#ffffff'
      fill: '#000000')
    this.stickyText.setScrollFactor 0

  testAlibiMessages: ->
    console.log 'testing alibi messages'