$ ->
  
  if ($infinite_scroll_container = $('.infinite_scroll')).length
    
    is_exhausted = no
    is_updating  = no
    page = 1
    
    update = ->
      is_updating = yes
      
      request = $.get('/', page: ++page)
      request.complete -> is_updating = no
      request.success (data) -> 
        data = $.trim(data)
        unless is_exhausted = data.length is 0
          $infinite_scroll_container.append('<hr>' + data)
          applyShowcase($infinite_scroll_container)
  
    $window = $(window)
    $window.scroll( -> 
      if $window.scrollTop() + 100 > $(document).height() - $window.height()  
        update() unless is_updating or is_exhausted
    )
      