class Alibi

  constructor: (id, message_suspect, id_witness1, message_confirm_witness1, message_unclear_witness1)->
    @id = id
    @message_suspect = message_suspect
    @id_witness1 = id_witness1
    @message_confirm_witness1 = message_confirm_witness1
    @message_unclear_witness1 = message_unclear_witness1

module.exports = Alibi
