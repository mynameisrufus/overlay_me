#= require 'overlay_me/draggable'

class OverlayMe.Overlays.DraggableImage extends OverlayMe.Draggable

  initialize: (attributes, options) ->
    super(attributes, options)
    @image = (new Backbone.View).make 'img', { src: options.image_src }
    $(@el).append @image

    # apply default_css if existing
    $(@el).css options.default_css if options.default_css

    # force positioning to 0 by default
    $(@el).css('left', '0px') if $(@el).css('left') == 'auto' || $(@el).css('left') == ''
    $(@el).css('top', '0px') if $(@el).css('top') == 'auto' || $(@el).css('top') == ''

    $(@el).bind 'mousedown', (event) =>
      @toggleMove(event)

    $(window).bind 'mouseup', (event) =>
      @endMove(event)

    $(@el).bind 'mouseover', (event) =>
      $(".overlay-image-block[data-img-id=#{@id}]").addClass 'hovered'

    $(@el).bind 'mouseout', (event) =>
      $(".overlay-image-block[data-img-id=#{@id}]").removeClass 'hovered'

  fitDivToImage: ->
    if @image.width > 0
      $(@el).css('width', @image.width)
      $(@el).css('height', @image.height)

  render: ->
    @el


