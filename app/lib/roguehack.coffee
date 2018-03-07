module.exports = class RogueHack

  CANVAS_WIDTH_INITIAL: 800
  CANVAS_HEIGHT_INITIAL: 500
  DEBUG: true
  KEY_FILE_ALIBI: 'file-alibi'
  LITERAL_COMMA_PLACEHOLDER: "|"
  PATH_DATA: './data/'

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

  displayGameMessage: (phaserReference, message) ->
    if @stickyText
      @stickyText.destroy()
    @stickyText = phaserReference.add.text(16, 16, message,
      fontSize: '18px'
      padding:
        x: 10
        y: 5
      backgroundColor: '#ffffff'
      fill: '#000000')
    @stickyText.setScrollFactor 0

  testAlibiMessages: (phaserReference) ->
    data_alibi = phaserReference.cache.text.get(@KEY_FILE_ALIBI)
    @log data_alibi

    data_alibi = data_alibi.split("\n")
    for line in data_alibi
      fields = line.split(',')
      for field in fields
        field = field.replace(@LITERAL_COMMA_PLACEHOLDER, ',')
        @log field
      @log "----"














