#= require 'draggable'

class OverlayMe.MenuClass extends OverlayMe.Draggable

  id: 'overlay_me_menu'

  className: 'overlayme-menu'

  template: '
    <div class="drag-me menu-header">
      Overlay Me
      <span class="menu-header__toggle"></span>
    </div>
    <div class="menu-list">
    </div>
  '

  initialize: (attributes) ->
    super(attributes, { default_css: { top: 50 } })

    # add it to the page
    $o('body').append @render()

    # add listeners
    $o(@el)
      .on 'mousedown', '.drag-me', (e) =>
        @toggleMove e

      .on 'mousedown', '.menu-header__toggle', (e) ->
        e.stopPropagation()

      .on 'click', '.menu-header__toggle', (e) ->
        OverlayMe.menu.toggleCollapse()

    $o(window)
      .on 'mouseup', (e) =>
        @endMove e 
      .on 'overlay_me:toggle_all_display', =>
        @toggleDisplay()

  append: (element) ->
    $o(@el).find('.menu-list').append element

  toggleCollapse: ->
    $o(@el).toggleClass 'collapsed'

  collapsed: ->
    $o(@el).hasClass 'collapsed'

  render: ->
    template = _.template @template, {}
    $o(@el).html template
    @el

# create a unique menu if conditions
if OverlayMe.mustLoad() # dont do it anytime
  # at DOM loaded
  $o ->
    OverlayMe.menu = new OverlayMe.MenuClass() unless OverlayMe.menu
