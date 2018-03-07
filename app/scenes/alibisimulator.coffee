AlibiManager = require('lib/alibimanager')
RogueHack = require('lib/roguehack')
roguehack = new RogueHack

module.exports =

  key: 'alibisimulator'

  preload: ->
    @load.text 'file-alibi', roguehack.PATH_DATA + 'alibi.csv'
    return

  create: ->
    messageToDisplay = ''

    alibiManager = new AlibiManager(this, roguehack)
    for alibi in alibiManager.getAlibis()
      messageToDisplay += alibi.getId() + "\n"
      console.log messageToDisplay

    roguehack.displayGameMessage(this, messageToDisplay)