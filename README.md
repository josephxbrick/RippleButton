# RippleButton

A Framer module that creates a button that exhibits the Material Design ripple effect when clicked.

Try out [this sample](https://framer.cloud/DHZTZ) to see an example button (which looks better than the gif below).

<img src="/readme_images/rippleButtonLarge.gif" width="100">

## Getting Started
If you have Modules installed, or want to install Modules to add this module to you project, click the badge below.

<a href='https://open.framermodules.com/RippleButton'>
    <img alt='Install with Framer Modules'
    src='https://www.framermodules.com/assets/badge@2x.png' width='160' height='40' />
</a>


Note that you can hit Ctrl+C in Modules (when RippleButton is the active module) to copy a code example that you can then paste into your file. 

If you are not using Modules, download `RippleButton.coffee`, place it in the `/modules` folder of your project, and in your coffeescript file, include the following.

`{RippleButton} = require "RippleButton"`
## Creating a RippleButton instance
The following creates a 400x120 RippleButton instance and changes the default animation options of the ripple button.
```
rippleButton = new RippleButton
  rippleOptions: time: 0.3, curve: Bezier.easeOut  # animation options for the ripple effect
  backgroundColor: "dodgerblue"
  width: 400
  height: 120
  text: "Options"  # label of button
```
## Properties
* **rippleColor**: the color of the circle that animates to create the animation (default: `rippleButton.backgroundColor.darken 10`)
* **rippleOptions**: the animationOptions for the ripple animation (default: `time: 0.25, curve: Bezier.easeOut`)
* **triggerOnClick**: (boolean) whether the animation is triggered by clicking the button (default: `true`). 

Note that you also can use any TextLayer property (except for the text shadow properties) to set text properties of the button label: 
```
rippleButton = new RippleButton
  text: "Options"
  font: Utils.loadWebFont "Roboto"
  fontWeight: 700
  letterSpacing: 2
  color: "white"
```
If you want to set the shadow of the button's text label, use the following properties instead, as `shadowX`, `shadowY`, `shadowBlur`, and `shadowColor` define the shadow for the button itself, not for the button's label.

* **textShadowX**: same as shadowX for a TextLayer instance
* **textShadowY**: same as shadowY for a TextLayer instance
* **textShadowBlur**: same as shadowBlur for a TextLayer instance
* **textShadowColor**: same as shadowColor for a TextLayer instance

## Defaults
Here are the defaults specified for a new RippleButton instance. (Other defaults are inherited from Layer defaults.)
```
backgroundColor: "cornflowerblue"
rippleColor: (the background color darkened by 10%)
rippleOptions: time: 0.2, curve: Bezier.easeOut
triggerOnClick: true
color: "white"
font: Utils.loadWebFont "Roboto"
fontSize: 24
text: "Button"
```
