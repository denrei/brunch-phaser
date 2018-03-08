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
      messageToDisplay += alibi.getId() + ": " + alibi.getMessage_Suspect() + "\n"
      messageToDisplay += alibi.getId_Witness1() + ": " + alibi.getMessageConfirm_Witness1() + "\n"
      messageToDisplay += alibi.getId_Witness1() + ": " + alibi.getMessageUnclear_Witness1() + "\n"
      messageToDisplay += "\n"
      console.log messageToDisplay

    roguehack.displayGameMessage(this, messageToDisplay)
