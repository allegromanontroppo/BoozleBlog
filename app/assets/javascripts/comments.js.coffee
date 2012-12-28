$ ->
  
  syncNumberOfComments = ->
    number_of_comments = $('#comments .media').length
    $('#comments h3').html "#{ number_of_comments } comment#{ if number_of_comments is 1 then '' else 's'}"
  
  $('#comments form').on('ajax:success', (e, data) ->
   
    $form = $(e.target)
    $form.before(data + '<hr>')
    
    syncNumberOfComments()
    
    $('#comments .media:last').highlight()
    $form.find('textarea').val('')
  )
  
  $('#comments').on('ajax:before', 'a[data-method="delete"]', (e) -> 
  
    $(e.target).closest('.media').slideUp ->
      $(this).next('hr').remove()
      $(this).remove()
    
      syncNumberOfComments()
  )
    