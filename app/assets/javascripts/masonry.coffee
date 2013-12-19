
//= require libs/jquery.imagesloaded
//= require libs/masonry.pkgd.min

$.fn.applyMasonry = ->  

  return unless @length

  @imagesLoaded => 
    @masonry(
      itemSelector: 'li'
      isAnimated: no
    )
    

$('article .photos').applyMasonry()