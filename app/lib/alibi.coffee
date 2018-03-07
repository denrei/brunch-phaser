class Alibi

  constructor: (id, message_suspect, id_witness1, message_confirm_witness1, message_unclear_witness1)->
    @id = id
    @message_suspect = message_suspect
    @id_witness1 = id_witness1
    @message_confirm_witness1 = message_confirm_witness1
    @message_unclear_witness1 = message_unclear_witness1

  getId: ->
    return @id

  getMessage_Suspect: ->
    return @id

  getId_Witness1: ->
    return @id

  getMessageConfirm_Witness1: ->
    return @id

  getMesageUnclear_Witness1: ->
    return @id

module.exports = Alibi
