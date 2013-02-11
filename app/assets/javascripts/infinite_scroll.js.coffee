$ ->
  
  if ($infinite_scroll_container = $('.posts')).length
    
    is_exhausted = no
    is_getting  = no
    page_number = 1
    
    getPage = ->
      is_getting = yes
      
      request = $.get('/', page: ++page_number)
      request.complete -> is_getting = no
      request.success (data) -> 
        data = $.trim(data)
        unless is_exhausted = data.length is 0
          $infinite_scroll_container.append('<hr>' + data)
          applyShowcase($infinite_scroll_container)
        else
          $('#next_page').hide()
          
  
    $('<button>',
      id: 'next_page'
      html: 'See more'
    ).on('click', ->
      getPage() unless is_getting or is_exhausted
    ).insertAfter($infinite_scroll_container)
      