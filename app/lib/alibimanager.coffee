class AlibiManager

  LITERAL_COMMA_PLACEHOLDER: "|"

  constructor: (phaserInstance, roguehack)->
    @phaserInstance = phaserInstance
    @roguehack = roguehack

  getFileInputLines: (phaserInstance) ->
    @data_alibi_original = @phaserInstance.cache.text.get('file-alibi')
    @roguehack.log @data_alibi_original
    lines = @data_alibi_original.split("\n")
    for line in lines
      fields = line.split(',')
      for field in fields
        field = field.replace(@LITERAL_COMMA_PLACEHOLDER, ',')
    return lines



module.exports = AlibiManager