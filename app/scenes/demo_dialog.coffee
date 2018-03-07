RogueHack = require('lib/roguehack')
roguehack = new RogueHack
module.exports =

  key: 'demo_dialog'

  preload: ->
    @load.text roguehack.KEY_FILE_ALIBI, roguehack.PATH_DATA + 'alibi.csv'
    return

  create: ->
    roguehack.displayGameMessage(this,"Dialog Demo")
