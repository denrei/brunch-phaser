module.exports = class RogueHack

  CANVAS_WIDTH_INITIAL: 480
  CANVAS_HEIGHT_INITIAL: 320
  DEBUG: true
  FONT: 'Futura,system-ui,sans-serif'
  PATH_DATA: './data/'
  ID_NPC_DABYL: 'dabyl' # string must match string in tilemap json
  ID_NPC_IVIKA: 'ivika'
  ID_NPC_SIVAN: 'sivan'
  ID_NPC_TON: 'ton'
  ID_NPC_VERA: 'vera'

  stickyText: null

  log: (message) ->
    if @DEBUG
      console.log message

  getViewportZoom: ->
    @log "intended canvas width  : #{ @CANVAS_WIDTH_INITIAL }px"
    @log "intended canvas height : #{ @CANVAS_HEIGHT_INITIAL }px"

    aspectRatio_intended = @CANVAS_WIDTH_INITIAL / @CANVAS_HEIGHT_INITIAL
    @log "intended aspect ratio  : #{ aspectRatio_intended }"

    zoom = window.innerWidth / @CANVAS_WIDTH_INITIAL
    @log "normally width is limiting"
    aspectRatio_viewport = window.innerWidth / window.innerHeight
    if aspectRatio_viewport > aspectRatio_intended
      @log "but now height is limiting"
      zoom = window.innerHeight / @CANVAS_HEIGHT_INITIAL

    @log "viewport width         : #{ window.innerWidth }px"
    @log "viewport height        : #{ window.innerHeight }px"
    @log "zoom                   : #{ zoom }x"
    return zoom

  displayGameMessage: (phaserInstance, message) ->
    if @stickyText
      @stickyText.destroy()
    @log message
    @stickyText = phaserInstance.add.text(16, 16, message,
      fontSize: '18px'
      padding:
        x: 10
        y: 5
      backgroundColor: '#ffffff'
      fill: '#000000')
    @stickyText.setScrollFactor 0
