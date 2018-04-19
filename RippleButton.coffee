# button that creates a ripple effect when clicked
class exports.RippleButton extends Layer
	constructor: (@options={}) ->
		# TextLayer that holds the button label
		@_buttonLabel = new TextLayer
		# layer that contains and clips the animation
		@_clipper = new Layer
			clip: true
			backgroundColor: ""
		# circle that animates to create ripple effect
		@_rippleCircle = new Layer
			name: "ripple"
			borderRadius: "50%"
			parent: @_clipper
			size: 0
		# class default properties
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
		# Can't set rippleColor's default before the super (above) because @backgroundColor
		# is not yet available. So set it now if the coder hasn't provided their own.
		if @options.rippleColor is "notSetByUser"
			@_rippleCircle.backgroundColor = @backgroundColor.darken 10
		@_clipper.parent = @
		@_buttonLabel.parent = @
		@_clipper.size = @size
		@_buttonLabel.point = Align.center
		
# EVENTS ==============================
	
		@on "change:size", ->
			@_clipper.size = @size
			@_buttonLabel.point = Align.center
		@_clipper.onClick (event, target) =>
			if @triggerOnClick is true
				@sendRipple event,target
				
# FUNCTIONS ==============================
	
	# Triggers ripple animation. Parameters event and target come from click/tap event.
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
				time: rippleAnimation.options.time * 2.5  # @_rippleCircle's fade takes 2.5 times longer than its resize
				curve: rippleAnimation.options.curve
		rippleAnimation.restart()
		fadeAnimation.restart()

	_longestRadius: (point, layer) ->
		pointToUpperLeft = Math.sqrt( Math.pow(point.x, 2) + Math.pow(point.y, 2))
		pointToUpperRight = Math.sqrt( Math.pow(layer.width - point.x, 2) + Math.pow(point.y, 2))
		pointToLowerLeft = Math.sqrt( Math.pow(point.x, 2) + Math.pow(layer.height - point.y, 2))
		pointToLowerRight = Math.sqrt( Math.pow(layer.width - point.x, 2) + Math.pow(layer.height - point.y, 2))
		return Math.max pointToUpperLeft, pointToUpperRight, pointToLowerLeft, pointToLowerRight

# GETTER/SETTERS ==============================
	
	# custom properties
	@define "rippleOptions",
		get: -> @_rippleCircle.animationOptions
		set: (value) -> @_rippleCircle.animationOptions = value
	@define "rippleColor",
		get: -> @_rippleCircle.backgroundColor
		set: (value) -> if value isnt "notSetByUser" then @_rippleCircle.backgroundColor = value
	@define "triggerOnClick",
		get: -> @options.triggerOnClick
		set: (value) -> @options.triggerOnClick = value

	# getters/setters for all TextLayer properties of @_buttonLabel
	@define "text",
		get: -> @_buttonLabel.text
		set: (value) -> @_buttonLabel.text = value; @_buttonLabel.point = Align.center
	@define "color",
		get: -> @_buttonLabel.color
		set: (value) -> @_buttonLabel.color = value
	@define "fontSize",
		get: -> @_buttonLabel.fontSize
		set: (value) -> @_buttonLabel.fontSize = value; @_buttonLabel.point = Align.center
	@define "fontWeight",
		get: -> @_buttonLabel.fontWeight
		set: (value) -> @_buttonLabel.fontWeight = value; @_buttonLabel.point = Align.center
	@define "fontFamily",
		get: -> @_buttonLabel.fontWeight
		set: (value) -> @_buttonLabel.fontWeight = value; @_buttonLabel.point = Align.center
	@define "fontStyle",
		get: -> @_buttonLabel.fontStyle
		set: (value) -> @_buttonLabel.fontStyle = value; @_buttonLabel.point = Align.center
	@define "font",
		get: -> @_buttonLabel.font
		set: (value) -> @_buttonLabel.font = value; @_buttonLabel.point = Align.center
	@define "padding",
		get: -> @_buttonLabel.padding
		set: (value) -> @_buttonLabel.padding = value; @_buttonLabel.point = Align.center
	@define "lineHeight",
		get: -> @_buttonLabel.lineHeight
		set: (value) -> @_buttonLabel.lineHeight = value; @_buttonLabel.point = Align.center
	@define "letterSpacing",
		get: -> @_buttonLabel.letterSpacing
		set: (value) -> @_buttonLabel.letterSpacing = value; @_buttonLabel.point = Align.center
	@define "wordSpacing",
		get: -> @_buttonLabel.wordSpacing
		set: (value) -> @_buttonLabel.wordSpacing = value; @_buttonLabel.point = Align.center
	@define "textAlign",
		get: -> @_buttonLabel.textAlign
		set: (value) -> @_buttonLabel.textAlign = value; @_buttonLabel.point = Align.center
	@define "textOverflow",
		get: -> @_buttonLabel.textOverflow
		set: (value) -> @_buttonLabel.textOverflow = value; @_buttonLabel.point = Align.center
	@define "template",
		get: -> @_buttonLabel.template
		set: (value) -> @_buttonLabel.template = value; @_buttonLabel.point = Align.center
	@define "templateFormatter",
		get: -> @_buttonLabel.templateFormatter
		set: (value) -> @_buttonLabel.templateFormatter = value; @_buttonLabel.point = Align.center
	@define "textTransform",
		get: -> @_buttonLabel.textTransform
		set: (value) -> @_buttonLabel.textTransform = value; @_buttonLabel.point = Align.center
	@define "textDecoration",
		get: -> @_buttonLabel.textDecoration
		set: (value) -> @_buttonLabel.textDecoration = value
	@define "textIndent",
		get: -> @_buttonLabel.textIndent
		set: (value) -> @_buttonLabel.textIndent = value; @_buttonLabel.point = Align.center
	@define "truncate",
		get: -> @_buttonLabel.truncate
		set: (value) -> @_buttonLabel.truncate = value; @_buttonLabel.point = Align.center
	@define "direction",
		get: -> @_buttonLabel.direction
		set: (value) -> @_buttonLabel.direction = value	
	@define "whiteSpace",
		get: -> @_buttonLabel.whiteSpace
		set: (value) -> @_buttonLabel.whiteSpace = value; @_buttonLabel.point = Align.center

	# rename these TextLayer properties, as not to interfere with the RippleButton instance's own shadow properties
	@define "textShadowX",
		get: -> @_buttonLabel.shadowX
		set: (value) -> @_buttonLabel.shadowX = value
	@define "textShadowY",
		get: -> @_buttonLabel.shadowY
		set: (value) -> @_buttonLabel.shadowY = value
	@define "textShadowBlur",
		get: -> @_buttonLabel.shadowBlur
		set: (value) -> @_buttonLabel.shadowBlur = value
	@define "textShadowColor",
		get: -> @_buttonLabel.shadowColor
		set: (value) -> @_buttonLabel.shadowColor = value
