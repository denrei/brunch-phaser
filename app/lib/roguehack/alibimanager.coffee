class AlibiManager

  COMMA_PLACEHOLDER: "|"
  NEWLINE: "\r\n" # thanks Google Drive
  alibis: []
  count_assigned_abilis: 0

  constructor: (phaserInstance, roguehack)->
    @phaserInstance = phaserInstance
    @roguehack = roguehack
    @_initializeAlibis()

  _getFileInputLines: () ->
    @data_alibi_original = @phaserInstance.cache.text.get('file-alibi')
    lines_original = @data_alibi_original.split(@NEWLINE)
    lines_toReturn = []
    for line_original in lines_original
      line_toReturn = []
      fields = line_original.split(',')
      for field in fields
        fieldToReturn = field.replace(@COMMA_PLACEHOLDER, ',')
        line_toReturn.push(fieldToReturn)
      lines_toReturn.push(line_toReturn)
    return lines_toReturn

  _initializeAlibis: () ->
    isHeaderLine = true
    for line in @_getFileInputLines()
      if isHeaderLine
        isHeaderLine = false
        continue
      id = line[0]
      message_suspect = line[1]
      id_witness1 = line[2]
      message_confirm_witness1 = line[3]
      message_unclear_witness1 = line[4]
      alibi = new window.roguehack.Alibi(id, message_suspect, id_witness1, message_confirm_witness1, message_unclear_witness1)
      @alibis.push(alibi)

  _getCapitalizedCharacterName: (name) ->
    return name.toUpperCase()

  getAlibis: () ->
    return @alibis

  assignAlibi: ->
    alibiToReturn = @alibis[@count_assigned_abilis]
    @count_assigned_abilis += 1
    return alibiToReturn

  displayAlibiForBody: (collidedBody) ->
    message = 'ouch'
    @roguehack.log 'checking alibi for collided body'
    if typeof(collidedBody.gameObject.alibi) == 'undefined'
      @roguehack.displayGameMessage(@phaserInstance, message)
      return
    message = ''
    message += @_getCapitalizedCharacterName(collidedBody.gameObject.name) + ":\n"
    message += collidedBody.gameObject.alibi.getMessage_Suspect()
    @roguehack.displayGameMessage(@phaserInstance, message)

module.exports = AlibiManager
