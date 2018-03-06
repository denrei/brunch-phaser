secretStuff =
  CANVAS_WIDTH_INITIAL: 800
  CANVAS_HEIGHT_INITIAL: 500

module.exports =
  RogueHack:

    CANVAS_WIDTH_INITIAL: secretStuff.CANVAS_WIDTH_INITIAL

    CANVAS_HEIGHT_INITIAL: secretStuff.CANVAS_HEIGHT_INITIAL

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
