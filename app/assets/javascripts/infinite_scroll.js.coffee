$ ->
  
  if ($infinite_scroll_container = $('.posts')).length
    
    is_exhausted = no
    is_getting  = no
    page_number = 1
    
    getPage = ->
      is_getting = yes
      
      promise = jQuery.Deferred()
      
      request = $.get('/', page: ++page_number)
      request.complete -> is_getting = no
      request.success (data) -> 
        data = $.trim(data)
        unless is_exhausted = data.length is 0
          $infinite_scroll_container.append('<hr>' + data)
          applyShowcase($infinite_scroll_container)
          promise.resolve(yes)
        else
          promise.resolve(no)
          
      return promise
  
    $('<button>',
      id: 'next_page'
      html: 'See more'
    ).on('click', ->
      unless is_getting or is_exhausted
        $this = $(@)
        $this.hide()
        getPage().done (success) -> $this.show() if success
        
    ).insertAfter($infinite_scroll_container)
      