# button that creates a ripple effect when clicked
class exports.RippleButton extends Layer
	constructor: (@options={}) ->
		_.defaults @options,
			backgroundColor: "cornflowerblue"
			rippleColor: undefined
			rippleOptions: time: 0.25, curve: Bezier.easeOut
			triggerOnClick: true
		super @options
		if @rippleColor is undefined
			@rippleColor = @backgroundColor.darken 10

		# layer that contains @_ripple circle
		@_clipper = new Layer
			size: @size
			parent: @
			clip: true
			backgroundColor: ""

		# circle that animates to create ripple effect
		@_ripple = new Layer
			name: "ripple"
			borderRadius: "50%"
			backgroundColor: @rippleColor
			parent: @_clipper
			size: 0
		@on "change:size", ->
			@_clipper.size = @size
		@_clipper.onClick (event, target) =>
			if @triggerOnClick is true
				@sendRipple event,target

	# triggers ripple animation
	# parameters event and target come from click event
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
					rippleAnimation.options.time * 2.5
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

	@define "rippleOptions",
		get: -> @options.rippleOptions
		set: (value) -> @options.rippleOptions = value
	@define "rippleColor",
		get: -> @options.rippleColor
		set: (value) -> @options.rippleColor = value
	@define "triggerOnClick",
		get: -> @options.triggerOnClick
		set: (value) -> @options.triggerOnClick = value
