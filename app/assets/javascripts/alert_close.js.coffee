$ ->
  $('[data-dismiss="alert"]').on('click', (e) ->
    $(e.target).closest('.alert').slideUp()
  )