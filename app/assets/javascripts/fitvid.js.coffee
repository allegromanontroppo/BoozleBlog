#= require libs/jquery.fitvids.min

$ -> 
  applyFitVid('body')
  $(document).on 'infinite-scroll', (e, new_content) -> applyFitVid(new_content)

applyFitVid = (selector) -> $(selector).fitVids()