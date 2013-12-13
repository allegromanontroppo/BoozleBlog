//= require libs/masonry.pkgd.min

urls =
  
  userId: '117383595187079962935'

  generate: (url, params = {}, jsonp) ->
    
    params['callback'] = '?' if jsonp
    
    "#{url}?" + (for param, value of params when value    
      "#{ param }=#{ if param is 'callback' then value else encodeURIComponent(value) }"
    ).join('&') 
    
  albums: (thumbsize = 220) ->

    endpoint = "https://picasaweb.google.com/data/feed/api/user/#{ encodeURIComponent @userId }"
    params = 
      kind: 'album'
      thumbsize: thumbsize
      alt: 'json'

    @generate endpoint, params, true

  photos: (albumId, thumbsize = 220, imgmax = 1024) ->

    endpoint = "https://picasaweb.google.com/data/feed/api/user/#{ encodeURIComponent @userId }/albumid/#{ albumId }"
    params = 
      kind: 'photo'
      thumbsize: thumbsize
      imgmax: imgmax
      alt: 'json'

    @generate endpoint, params, true

  photo: (albumId, photoId) ->

    endpoint = "https://picasaweb.google.com/data/feed/api/user/#{ encodeURIComponent @userId }/albumid/#{ albumId }/photoid/#{ photoId }"
    params = 
      imgmax: 'd'
      alt: 'json'

    @generate endpoint, params
    
picasa =    
      
  albums: -> 
    
    deferred = $.Deferred()
    request = $.getJSON urls.albums()
    request.done (response) -> deferred.resolve(response?.feed?.entry ? [])
      
    deferred.promise()
    
  photos: (album_id) -> 
  
    deferred = $.Deferred()
    request = $.getJSON urls.photos(album_id)
    request.done (response) -> deferred.resolve(response?.feed?.entry ? [])
    
    deferred.promise()
      
  photo: (album_id, photo_id) ->

    deferred = $.Deferred()
    request = $.getJSON urls.photo(album_id, photo_id)
    request.done (response) ->  deferred.resolve(response?.feed)

    deferred.promise()
    
$ ->
  
  $albums_selector = $('#picasa_album')
  $gallery = $('#photos-picasa-gallery')
  
  onPhotosLoaded = (photos) ->
    markup = ''
    LI_TEMPLATE = '<li data-link="{{photo_link}}" data-url="{{photo_url}}" data-height="{{photo_height}}" data-width="{{photo_width}}">
                    <div class="thumbnail">
                      <img src="{{thumbnail_url}}">
                    </div>
                   </li>'

    for photo in photos
      if thumbnail = photo.media$group?.media$thumbnail?[0]
        markup += templator(LI_TEMPLATE, {
          photo_link: photo.link[1].href
          photo_url: photo.content.src
          photo_height: photo.gphoto$height.$t
          photo_width: photo.gphoto$width.$t
          thumbnail_url: thumbnail.url
        })
        
    $gallery.html(markup).trigger('photos-loaded')
  
  onAlbumsLoaded = (albums) ->
    for album in albums when album.gphoto$numphotos.$t
      $('<option>'
        value: album.gphoto$id.$t
        text: album.title.$t
      ).appendTo($albums_selector)
      
  selected_photos = ->
    for selected in $gallery.find('.selected')
      $selected = $(selected)
      {
        page_link: $selected.data('link')
        image_url: $selected.data('url')
        image_height: $selected.data('height')
        image_width: $selected.data('width')
      }
      
  templator = (s, d) ->
    for p of d
      s = s.replace(new RegExp("{{" + p + "}}", "g"), d[p])
    s
    
  applyMasonry = ->  

    $container = $(this)
    return unless $container.length

    $container.imagesLoaded -> 
      $container.masonry(
        itemSelector: 'li'
        isAnimated: no
      )
      
  $('form').on('submit', (e) ->
  
    $form = $(this)
    index = 0
    PHOTO_EMBED_TEMPLATE = '<a href="{{page_link}}"><img src="{{image_url}}" height="{{image_height}}" width="{{image_width}}" /></a>'
    
    for selected_photo in selected_photos()
      $('<input>'
        type: 'hidden'
        name: "post[photos_attributes][#{ --index }][embed]"
        value: templator(PHOTO_EMBED_TEMPLATE, selected_photo)
      ).appendTo($form)
  )   
      
  promise = picasa.albums()
  promise.done(onAlbumsLoaded)
  
  $albums_selector.on('change', ->
    if album_id = $(this).val()
      promise = picasa.photos(album_id)
      promise.done(onPhotosLoaded)
  )
  
  $gallery.bind('photos-loaded', applyMasonry)
  $gallery.on('click', 'li', ->
    $li = $(this)
    if $li.hasClass('selected')
      $li.removeClass('selected')
    else
      $li.addClass('selected')
  )
     
