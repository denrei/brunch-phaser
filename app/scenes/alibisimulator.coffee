AlibiManager = require('lib/alibimanager')
RogueHack = require('lib/roguehack')
roguehack = new RogueHack

module.exports =

  key: 'alibisimulator'

  preload: ->
    @load.text 'file-alibi', roguehack.PATH_DATA + 'alibi.csv'
    return

  create: ->
    roguehack.displayGameMessage(this,"Alibi Simulator")

    alibiManager = new AlibiManager(this, roguehack)
    for alibi in alibiManager.getAlibis()
      roguehack.log alibi
