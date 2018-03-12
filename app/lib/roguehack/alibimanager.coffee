class AlibiManager

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

  _shuffleArray: (inputArray) ->
    arrayToReturn = []
    picked = 0
    N = inputArray.length
    isAvailable = {}
    for i in [0..(N-1)]
      isAvailable[i] = true
    while picked < N
      subscript = parseInt(Math.random() * 5)
      if isAvailable[subscript]
        isAvailable[subscript] = false
        arrayToReturn.push(inputArray[subscript])
        picked += 1
    return arrayToReturn

  _getAlibiForSuspect: (id_suspect) ->
    for alibi in @alibis
      if id_suspect == alibi.getId_Suspect()
        return alibi
    return null

  _initializeAlibis: () ->
    isHeaderLine = true
    i = 0
    alibis_unshuffled = []
    for line in @_getFileInputLines()
      if isHeaderLine
        isHeaderLine = false
        continue
      id = line[0]
      message_suspect = line[1]
      id_witness1 = line[2]
      message_confirm_witness1 = line[3]
      message_unclear_witness1 = line[4]
      alibi = new window.roguehack.Alibi(id, window.roguehack.Constant.ID_NPC_NOBODY, message_suspect, id_witness1, message_confirm_witness1, message_unclear_witness1)
      alibis_unshuffled.push(alibi)
      i += 1
    subscript_falseAlibi = parseInt(Math.random() * 5)
    alibis_unshuffled[subscript_falseAlibi].setIsAlibiTruthful(false)
    @alibis = @_shuffleArray(alibis_unshuffled)

  _accuseSuspect: (id_suspect) ->
    alibi = @_getAlibiForSuspect(id_suspect)

    #TODO: chief asks if player is sure

    @guiManager.log 'player accuses ' + id_suspect
    if alibi.getIsAlibiTruthful()
      @guiManager.displayGameMessage(@phaserInstance, 'You lose! You wrongfully accused ' + alibi.getId_Suspect().toUpperCase() + ".")
      return
    @guiManager.displayGameMessage(@phaserInstance, 'You found a hole in ' + alibi.getId_Suspect().toUpperCase() + "'s alibi. Congratulations!")

  # --------------------------------------------------------------------------------------------------------------------

  constructor: (phaserInstance, numberOfSuspects)->
    @COMMA_PLACEHOLDER = "|"
    @NEWLINE = "\r\n" # thanks Google Drive

    @NULL_ALIBI_CHIEF = new window.roguehack.Alibi('', window.roguehack.Constant.ID_NPC_CHIEF, '', '', '', '')
    @MESSAGE_GOODBYE = "Goodbye"
    @MESSAGE_CONTINUE = "Next"
    @MESSAGE_SCENARIO_DESCRIPTION = "Just got this report.  There was a murder last night.  Gunther Carlson's clone was was shot dead last night at 11:10PM in Mr. Carlson's estate.\n\nIt's clear the real target was billionaire Carlson himself.  Clones' lives are expendable.  His is not.  We've spoken with Carlson, who was doing a lot of finger pointing.  Here are the primary suspects..."
    @alibis = []
    @count_abilis_assigned = 0
    @count_abilis_false = 0
    @isFirstConversationWithChief = true

    @phaserInstance = phaserInstance
    @numberOfSuspects = numberOfSuspects
    @guiManager = new window.roguehack.GUIManager()

    @_initializeAlibis()

  getAlibis: () ->
    return @alibis

  assignAlibi: (id_suspect) ->
    @alibis[@count_abilis_assigned].setId_Suspect(id_suspect)
    @count_abilis_assigned += 1

  displayAlibiForBody: (collidedBody) ->
    message = 'ouch'
    @guiManager.log 'checking alibi for collided body'
    alibi = @_getAlibiForSuspect(collidedBody.gameObject.name)
    if !alibi
      @guiManager.displayGameMessage(@phaserInstance, message)
      return

    preamble = ''
    preamble += alibi.getId_Suspect().toUpperCase() + ":\n"
    preamble += alibi.getMessage_Suspect()

    options = []
    options.push({
      message: @MESSAGE_GOODBYE
    })
    @guiManager.displayClickableDialogOptions(@phaserInstance, preamble, options)

  handleDialogWithChief: ->

    callback_depth_1 = =>
      suspectIds = [
        window.roguehack.Constant.ID_NPC_DABYL,
        window.roguehack.Constant.ID_NPC_IVIKA,
        window.roguehack.Constant.ID_NPC_SIVAN,
        window.roguehack.Constant.ID_NPC_TON,
        window.roguehack.Constant.ID_NPC_VERA,
      ]
      options_depth_1 = []
      for suspectId in suspectIds
        options_depth_1.push({
          thumbnail: suspectId
          message: suspectId.toUpperCase().padEnd(6)
          callback: => @_accuseSuspect(suspectId)
        })
      options_depth_1.push({
        message: @MESSAGE_GOODBYE
        callback: window.roguehack.Constant.NULL_CALLBACK
      })
      preamble_depth_1 = window.roguehack.Constant.ID_NPC_CHIEF.toUpperCase() + ':\n' + 'Here are the usual suspects.'
      @guiManager.displayClickableDialogOptions(@phaserInstance, preamble_depth_1, options_depth_1)

#    preamble_depth_0 = window.roguehack.Constant.ID_NPC_CHIEF.toUpperCase() + ':\n' + @MESSAGE_SCENARIO_DESCRIPTION
#    options_depth_0 = []
#    options_depth_0.push({
#      message: @MESSAGE_CONTINUE
#      callback: callback_depth_1
#    })
#    if @isFirstConversationWithChief
#      @isFirstConversationWithChief = false
#      @guiManager.displayClickableDialogOptions(@phaserInstance, preamble_depth_0, options_depth_0)
#      return
    callback_depth_1()

module.exports = AlibiManager
