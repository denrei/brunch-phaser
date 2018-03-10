class Alibi

  constructor: (isAlibiTruthful, id, message_suspect, id_witness1, message_confirm_witness1, message_unclear_witness1)->
    @isAlibiTruthful = isAlibiTruthful
    @id = id
    @message_suspect = message_suspect
    @id_witness1 = id_witness1
    @message_confirm_witness1 = message_confirm_witness1
    @message_unclear_witness1 = message_unclear_witness1

  getIsAlibiTruthful: ->
    return @isAlibiTruthful

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

module.exports = Alibi
