class AlibiManager

  AlibiManager._getFileInputLines = () ->
    AlibiManager.data_alibi_original = AlibiManager.phaserInstance.cache.text.get('file-alibi')
    lines_original = AlibiManager.data_alibi_original.split(AlibiManager.NEWLINE)
    lines_toReturn = []
    for line_original in lines_original
      line_toReturn = []
      fields = line_original.split(',')
      for field in fields
        fieldToReturn = field.replace(AlibiManager.COMMA_PLACEHOLDER, ',')
        line_toReturn.push(fieldToReturn)
      lines_toReturn.push(line_toReturn)
    return lines_toReturn

  AlibiManager._generateTruthinessForAlibi = (i) ->
    if AlibiManager.count_abilis_false > 0
      return true

    if i == (AlibiManager.numberOfSuspects - 1)
      AlibiManager.count_abilis_false += 1
      return false

    isAlibiTruthful = Math.random() > 0.5
    if !isAlibiTruthful
      AlibiManager.count_abilis_false += 1
    return isAlibiTruthful

  AlibiManager._shuffleArray = (inputArray) ->
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

  AlibiManager._getAlibiForSuspect = (id_suspect) ->
    for alibi in AlibiManager.alibis
      if id_suspect == alibi.getId_Suspect()
        return alibi
    return null

  AlibiManager._initializeAlibis = () ->
    isHeaderLine = true
    i = 0
    alibis_unshuffled = []
    for line in AlibiManager._getFileInputLines()
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
    AlibiManager.alibis = AlibiManager._shuffleArray(alibis_unshuffled)

  AlibiManager._accuseSuspect = (id_suspect) ->
    alibi = AlibiManager._getAlibiForSuspect(id_suspect)

    #TODO: chief asks if player is sure

    AlibiManager.guiManager.log 'player accuses ' + id_suspect
    if alibi.getIsAlibiTruthful()
      AlibiManager.guiManager.displayGameMessage(AlibiManager.phaserInstance, 'You lose! You wrongfully accused ' + alibi.getId_Suspect().toUpperCase() + ".")
      return
    AlibiManager.guiManager.displayGameMessage(AlibiManager.phaserInstance, 'You found a hole in ' + alibi.getId_Suspect().toUpperCase() + "'s alibi. Congratulations!")

  # --------------------------------------------------------------------------------------------------------------------

  constructor: (phaserInstance, numberOfSuspects)->
    AlibiManager.COMMA_PLACEHOLDER = "|"
    AlibiManager.NEWLINE = "\r\n" # thanks Google Drive

    AlibiManager.NULL_ALIBI_CHIEF = new window.roguehack.Alibi('', window.roguehack.Constant.ID_NPC_CHIEF, '', '', '', '')
    AlibiManager.MESSAGE_GOODBYE = "Goodbye"
    AlibiManager.MESSAGE_CONTINUE = "Next"
    AlibiManager.MESSAGE_SCENARIO_DESCRIPTION = "Just got this report.  There was a murder last night.  Gunther Carlson's clone was was shot dead last night at 11:10PM in Mr. Carlson's estate.\n\nIt's clear the real target was billionaire Carlson himself.  Clones' lives are expendable.  His is not.  We've spoken with Carlson, who was doing a lot of finger pointing.  Here are the primary suspects..."
    AlibiManager.alibis = []
    AlibiManager.count_abilis_assigned = 0
    AlibiManager.count_abilis_false = 0
    AlibiManager.isFirstConversationWithChief = true

    AlibiManager.numberOfSuspects = numberOfSuspects
    AlibiManager.guiManager = new window.roguehack.GUIManager()
    AlibiManager.phaserInstance = phaserInstance

    AlibiManager._initializeAlibis()

  getAlibis: () ->
    return AlibiManager.alibis

  assignAlibi: (id_suspect) ->
    AlibiManager.alibis[AlibiManager.count_abilis_assigned].setId_Suspect(id_suspect)
    AlibiManager.count_abilis_assigned += 1

  displayAlibiForBody: (suspect_id) ->
    message = 'ouch'
    AlibiManager.guiManager.log 'checking alibi for collided body'
    alibi = AlibiManager._getAlibiForSuspect(suspect_id)
    if !alibi
      AlibiManager.guiManager.displayGameMessage(AlibiManager.phaserInstance, message)
      return

    preamble = ''
    preamble += alibi.getId_Suspect().toUpperCase() + ":\n"
    preamble += alibi.getMessage_Suspect()

    options = []
    options.push({
      message: AlibiManager.MESSAGE_GOODBYE
      callback: window.roguehack.Constant.NULL_CALLBACK
    })
    AlibiManager.guiManager.displayClickableDialogOptions(AlibiManager.phaserInstance, preamble, options)

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
          callback: => AlibiManager._accuseSuspect(suspectId)
        })
      options_depth_1.push({
        message: AlibiManager.MESSAGE_GOODBYE
        callback: window.roguehack.Constant.NULL_CALLBACK
      })
      preamble_depth_1 = window.roguehack.Constant.ID_NPC_CHIEF.toUpperCase() + ':\n' + 'Here are the usual suspects.'
      AlibiManager.guiManager.displayClickableDialogOptions(AlibiManager.phaserInstance, preamble_depth_1, options_depth_1)

#    preamble_depth_0 = window.roguehack.Constant.ID_NPC_CHIEF.toUpperCase() + ':\n' + AlibiManager.MESSAGE_SCENARIO_DESCRIPTION
#    options_depth_0 = []
#    options_depth_0.push({
#      message: AlibiManager.MESSAGE_CONTINUE
#      callback: callback_depth_1
#    })
#    if AlibiManager.isFirstConversationWithChief
#      AlibiManager.isFirstConversationWithChief = false
#      AlibiManager.guiManager.displayClickableDialogOptions(AlibiManager.phaserInstance, preamble_depth_0, options_depth_0)
#      return
    callback_depth_1()

module.exports = AlibiManager
