RogueHack = require('lib/roguehack')
roguehack = new RogueHack
module.exports =

  key: 'demo_dialog'

  preload: ->
    @load.text roguehack.KEY_FILE_ALIBI, roguehack.PATH_DATA + 'alibi.csv'
    return

  create: ->
    roguehack.displayGameMessage(this,"Dialog Demo")

    @data_alibi_original = @cache.text.get(roguehack.KEY_FILE_ALIBI)
    roguehack.log @data_alibi_original
    lines = @data_alibi_original.split("\n")
    for line in lines
      fields = line.split(',')
      for field in fields
        field = field.replace(@LITERAL_COMMA_PLACEHOLDER, ',')
        roguehack.log field
      roguehack.log "----"
