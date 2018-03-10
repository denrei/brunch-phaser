class AlibiManager

  COMMA_PLACEHOLDER: "|"
  NEWLINE: "\r\n" # thanks Google Drive
  alibis: []
  count_abilis_assigned: 0
  count_abilis_false: 0

  constructor: (phaserInstance, numberOfSuspects)->
    @phaserInstance = phaserInstance
    @numberOfSuspects = numberOfSuspects
    @guiManager = new window.roguehack.GUIManager()
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

  _generateTruthinessForAlibi: (i) ->
    if @count_abilis_false > 0
      return true

    if i == (@numberOfSuspects - 1)
      @count_abilis_false += 1
      return false

    isAlibiTruthful = Math.random() > 0.5
    if !isAlibiTruthful
      @count_abilis_false += 1
    return isAlibiTruthful

  _initializeAlibis: () ->
    isHeaderLine = true
    i = 0
    for line in @_getFileInputLines()
      if isHeaderLine
        isHeaderLine = false
        continue
      id = line[0]
      message_suspect = line[1]
      id_witness1 = line[2]
      message_confirm_witness1 = line[3]
      message_unclear_witness1 = line[4]
      alibi = new window.roguehack.Alibi(@_generateTruthinessForAlibi(i), id, message_suspect, id_witness1, message_confirm_witness1, message_unclear_witness1)
      @alibis.push(alibi)
      i += 1

  getAlibis: () ->
    return @alibis

  assignAlibi: ->
    alibiToReturn = @alibis[@count_abilis_assigned]
    @count_abilis_assigned += 1
    return alibiToReturn

  displayAlibiForBody: (collidedBody) ->
    message = 'ouch'
    @guiManager.log 'checking alibi for collided body'
    if typeof(collidedBody.gameObject.alibi) == 'undefined'
      @guiManager.displayGameMessage(@phaserInstance, message)
      return

    message = ''
    message += collidedBody.gameObject.name.toUpperCase() + ":\n"
    message += collidedBody.gameObject.alibi.getMessage_Suspect()
    @guiManager.displayGameMessage(@phaserInstance, message)

    dummyCallback1 = =>
      console.log 'Player accused the suspect'

    dummyCallback2 = =>
      console.log 'Player left the conversation'

    options = []
    option1 = {
      message: '> Accuse suspect'
      callback: dummyCallback1
    }
    option2 = {
      message: '> Cancel'
      callback: dummyCallback2
    }
    options.push(option1)
    options.push(option2)
    @guiManager.displayClickableDialogOptions(@phaserInstance, options)

module.exports = AlibiManager
