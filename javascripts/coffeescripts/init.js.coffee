# initialize Models/Views namespaces
this.OverlayMe = {}
this.OverlayMe.Mixin = {}
this.OverlayMe.Overlays = {}

# to build the 1 file minified version, we insert the minified CSS directly there
# dirty but so convenient!
OverlayMe.injectCSS = ->
  $o('head').append('<style rel="stylesheet" type="text/css">#CSS_BLOB#</style>')

# add a flag to stop crazy bookmarklet clicking
OverlayMe.isLoaded = ->
  window.overlay_me_loaded

OverlayMe.setLoaded = ->
  window.overlay_me_loaded = true

# check if browser is a mobile device
OverlayMe.isMobile = ->
  OverlayMe.userAgent().match /(iPhone|iPod|iPad|Android)/

# give a shortName method for checks in the app
OverlayMe.mustLoad = ->
  !OverlayMe.isLoaded() && !OverlayMe.isMobile()

# helper to clear all stored informations and reload the page
OverlayMe.clearAndReload = ->
  localStorage.clear()
  OverlayMe.pageReload()

OverlayMe.toggle = ->
  $o(window).trigger 'overlay_me:toggle_all_display'
  $o(window).trigger 'overlay_me:toggle_overlay_me_images_container_display'

# separate system calls in a local functions (allow tests stubing)
OverlayMe.pageReload = ->
  window.location.reload()
OverlayMe.userAgent = ->
  navigator.userAgent

# move last image touched by keypress
OverlayMe.moveLast = (dirs, multiplier = 1) ->
  lastMovedId = localStorage.getItem 'last-moved'
  image = $o("##{lastMovedId}")
  image.css 
    left: image.position().left + dirs[0] * multiplier
    top:  image.position().top  + dirs[1] * multiplier
  .trigger 'save'

OverlayMe.initKeyMoves = ->
  moves =
    'left':  [-1, 0], 
    'right': [1, 0], 
    'down':  [0, 1], 
    'up':    [0, -1] 

  $o.each moves, (keyPressed, dirs) ->
    key keyPressed, ->
      OverlayMe.moveLast dirs
      false
    key "shift+#{keyPressed}", ->
      OverlayMe.moveLast dirs, 15
      false

OverlayMe.Overlays.urlToId = (url) ->
  return url.replace(/[.:\/]/g, '_').replace(/[^a-zA-Z0-9_\-]/g, '')

OverlayMe.unicorns = [
  "http://fc07.deviantart.net/fs49/f/2009/200/b/3/Fat_Unicorn_and_the_Rainbow_by_la_ratta.jpg",
  "http://www.deviantart.com/download/126388773/Unicorn_Pukes_Rainbow_by_Angel35W.jpg",
  "http://macmcrae.com/wp-content/uploads/2010/02/unicorn.jpg",
  "http://4.bp.blogspot.com/-uPLiez-m9vY/TacC_Bmsn3I/AAAAAAAAAyg/jusQIA8aAME/s1600/Behold_A_Rainbow_Unicorn_Ninja_by_Jess4921.jpg",
  "http://www.everquestdragon.com/everquestdragon/main/image.axd?picture=2009%2F9%2FPaperPaperNewrainbow.png"
]

