# button that creates a ripple effect when clicked
class exports.RippleButton extends Layer
	constructor: (@options={}) ->
		# TextLayer that holds the button label
		@_textLayer = new TextLayer
		# layer that contains and clips the animation
		@_clipper = new Layer
			clip: true
			backgroundColor: ""
		# circle that animates to create ripple effect
		@_ripple = new Layer
			name: "ripple"
			borderRadius: "50%"
			parent: @_clipper
			size: 0
		_.defaults @options,
			backgroundColor: "cornflowerblue"
			rippleColor: "notSetByUser"
			rippleOptions: time: 0.2, curve: Bezier.easeOut
			triggerOnClick: true
			color: "white"
			font: Utils.loadWebFont "Roboto"
			fontSize: 24
			text: "Button"
		super @options

		# Can't set default for rippleColor above because @backgroundColor is not yet available,
		# so we set it here.
		if @options.rippleColor is "notSetByUser"
			@_ripple.backgroundColor = @backgroundColor.darken 10

		@_clipper.parent = @
		@_textLayer.parent = @
		@_clipper.size = @size
		@_textLayer.point = Align.center

		@on "change:size", ->
			@_clipper.size = @size
			@_textLayer.point = Align.center

		@_clipper.onClick (event, target) =>
			if @triggerOnClick is true
				@sendRipple event,target

	# Triggers ripple animation. Parameters event and target come from click event.
	sendRipple: (event, target) ->
		clickPoint = target.convertPointToLayer(event.point, target)
		r = @selectChild("ripple")
		r.size = 0
		r.midX = clickPoint.x
		r.midY = clickPoint.y
		r.opacity = 1
		radius = @_longestRadius clickPoint, @
		rippleAnimation = new Animation r,
			size: radius * 2
			x: clickPoint.x - radius
			y: clickPoint.y - radius
			options: @rippleOptions
		fadeAnimation = new Animation r,
			opacity: 0
			options:
				time:
					rippleAnimation.options.time * 2.5 # "magic" ratio that feels right
				curve:
					rippleAnimation.options.curve
		rippleAnimation.restart()
		fadeAnimation.restart()

	_longestRadius: (point, layer) ->
		pointToUpperLeft = Math.sqrt( Math.pow(point.x, 2) + Math.pow(point.y, 2))
		pointToUpperRight = Math.sqrt( Math.pow(layer.width - point.x, 2) + Math.pow(point.y, 2))
		pointToLowerLeft = Math.sqrt( Math.pow(point.x, 2) + Math.pow(layer.height - point.y, 2))
		pointToLowerRight = Math.sqrt( Math.pow(layer.width - point.x, 2) + Math.pow(layer.height - point.y, 2))
		return Math.max pointToUpperLeft, pointToUpperRight, pointToLowerLeft, pointToLowerRight

	# handle setting/getting custom properties
	@define "rippleOptions",
		get: -> @_ripple.animationOptions
		set: (value) -> @_ripple.animationOptions = value
	@define "rippleColor",
		get: -> @_ripple.backgroundColor
		set: (value) -> if value isnt "notSetByUser" then @_ripple.backgroundColor = value
	@define "triggerOnClick",
		get: -> @options.triggerOnClick
		set: (value) -> @options.triggerOnClick = value

	# handle getting/setting text properties, so it feels like using TextLayer
	@define "text",
		get: -> return @_textLayer.text
		set: (value) -> @_textLayer.text = value; @_textLayer?.point = Align.center
	@define "color",
		get: -> return @_textLayer.color
		set: (value) -> @_textLayer.color = value
	@define "fontSize",
		get: -> return @_textLayer.fontSize
		set: (value) -> @_textLayer.fontSize = value; @_textLayer?.point = Align.center
	@define "fontWeight",
		get: -> return @_textLayer.fontWeight
		set: (value) -> @_textLayer.fontWeight = value; @_textLayer?.point = Align.center
	@define "fontFamily",
		get: -> return @_textLayer.fontWeight
		set: (value) -> @_textLayer.fontWeight = value; @_textLayer?.point = Align.center
	@define "fontStyle",
		get: -> return @_textLayer.fontStyle
		set: (value) -> @_textLayer.fontStyle = value; @_textLayer?.point = Align.center
	@define "font",
		get: -> return @_textLayer.font
		set: (value) -> @_textLayer.font = value; @_textLayer?.point = Align.center
	@define "padding",
		get: -> return @_textLayer.padding
		set: (value) -> @_textLayer.padding = value; @_textLayer?.point = Align.center
	@define "lineHeight",
		get: -> return @_textLayer.lineHeight
		set: (value) -> @_textLayer.lineHeight = value; @_textLayer?.point = Align.center
	@define "letterSpacing",
		get: -> return @_textLayer.letterSpacing
		set: (value) -> @_textLayer.letterSpacing = value; @_textLayer?.point = Align.center
	@define "wordSpacing",
		get: -> return @_textLayer.wordSpacing
		set: (value) -> @_textLayer.wordSpacing = value; @_textLayer?.point = Align.center
	@define "textAlign",
		get: -> return @_textLayer.textAlign
		set: (value) -> @_textLayer.textAlign = value; @_textLayer?.point = Align.center
	@define "textOverflow",
		get: -> return @_textLayer.textOverflow
		set: (value) -> @_textLayer.textOverflow = value; @_textLayer?.point = Align.center
	@define "template",
		get: -> return @_textLayer.template
		set: (value) -> @_textLayer.template = value; @_textLayer?.point = Align.center
	@define "templateFormatter",
		get: -> return @_textLayer.templateFormatter
		set: (value) -> @_textLayer.templateFormatter = value; @_textLayer?.point = Align.center
	@define "textTransform",
		get: -> return @_textLayer.textTransform
		set: (value) -> @_textLayer.textTransform = value; @_textLayer?.point = Align.center
	@define "textDecoration",
		get: -> return @_textLayer.textDecoration
		set: (value) -> @_textLayer.textDecoration = value
	@define "textIndent",
		get: -> return @_textLayer.textIndent
		set: (value) -> @_textLayer.textIndent = value; @_textLayer?.point = Align.center
	@define "truncate",
		get: -> return @_textLayer.truncate
		set: (value) -> @_textLayer.truncate = value; @_textLayer?.point = Align.center
	@define "direction",
		get: -> return @_textLayer.direction
		set: (value) -> @_textLayer.direction = value	
	@define "whiteSpace",
		get: -> return @_textLayer.whiteSpace
		set: (value) -> @_textLayer.whiteSpace = value; @_textLayer?.point = Align.center
	@define "shadowX",
		get: -> return @_textLayer.shadowX
		set: (value) -> @_textLayer.shadowX = value
	@define "shadowY",
		get: -> return @_textLayer.shadowY
		set: (value) -> @_textLayer.shadowY
	@define "shadowBlur",
		get: -> return @_textLayer.shadowBlur
		set: (value) -> @_textLayer.shadowBlur = value
	@define "shadowColor",
		get: -> return @_textLayer.shadowColor
		set: (value) -> @_textLayer.shadowColor = value
