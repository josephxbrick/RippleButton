# RippleButton
A Framer module that creates a button that exhibits the Material Design ripple effect when clicked.
## Getting Started
If you have Modules installed, or want to use Modules to add this module to you project, click the badge below.

< link forthcoming >

Note that you can hit Ctrl+C in Modules (when RippleButton is the active module) to copy a code example that you can then paste into your file. 

If you are not using Modules, download `RippleButton.coffee`, place it in the `/modules` folder of your project, and in your coffeescript file, include the following.

`{RippleButton} = require "RippleButton"`
## Creating a RippleButton instance
The following creates a dodger-blue 400x120 RippleButton instance:
```
rippleButton = new RippleButton
  width: 400
  height: 120
  backgroundColor: "dodgerblue"
  text: "Options" # label of button
  fontSize: 18  # fontSize of label
  color: "white" # color of label
```
## Properties
* **rippleColor**: the color of the circle that animates to create the animation (default: rippleButton.backgroundColor.darken 10)
* **rippleOptions**: the animationOptions for the ripple animation (default: `time: 0.25, curve: Bezier.easeOut`)
* **triggerOnClick**: (boolean) whether the animation is triggered by clicking the button (default: `true`). 

Note that you also can use any TextLayer property to set properties of the button label.
