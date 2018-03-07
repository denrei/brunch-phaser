RogueHack = require('lib/roguehack')
AlibiManager = require('lib/alibimanager')
roguehack = new RogueHack
alibiManager = new AlibiManager(roguehack)

module.exports =

  key: 'alibisimulator'

  preload: ->
    @load.text 'file-alibi', roguehack.PATH_DATA + 'alibi.csv'
    return

  create: ->
    roguehack.displayGameMessage(this,"Alibi Simulator")

    for line in alibiManager.getFileInputLines(this)
      roguehack.log line
