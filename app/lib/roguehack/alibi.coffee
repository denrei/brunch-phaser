class Alibi

  constructor: (id, id_suspect, message_suspect, id_witness1, message_confirm_witness1, message_unclear_witness1)->
    @isAlibiTruthful = true
    @id = id
    @id_suspect = id_suspect
    @message_suspect = message_suspect
    @id_witness1 = id_witness1
    @message_confirm_witness1 = message_confirm_witness1
    @message_unclear_witness1 = message_unclear_witness1

  getId: ->
    return @id

  getMessage_Suspect: ->
    return @message_suspect

  getId_Witness1: ->
    return @id_witness1

  getMessageConfirm_Witness1: ->
    return @message_confirm_witness1

  getMessageUnclear_Witness1: ->
    return @message_unclear_witness1

  getIsAlibiTruthful: ->
    return @isAlibiTruthful

  setIsAlibiTruthful: (isAlibiTruthful) ->
    @isAlibiTruthful = isAlibiTruthful

  getId_Suspect: ->
    return @id_suspect

  setId_Suspect: (id_suspect) ->
    @id_suspect = id_suspect


module.exports = Alibi
