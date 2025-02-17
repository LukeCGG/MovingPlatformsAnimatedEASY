Want to make a 2D moving platform in Godot? YouTube tutorials too hard and restricting? You've come to the right place, it's never been more simple!
- Tested on Godot 4.3 (But probably works on older and newer versions) -

Now with Rotation! - 1.9+

1. Start by dropping the Platform scene into your Level
2. Right click it in the scene tree
3. Select Editable Children
4. Relocate the Marker2D and Boom! Moving Platforms!

FOR JUST PLATFORMS
- Platforms by default are set to "Auto", this mean that they will start moving when the level is loaded.
- Each platform will move independently from each other to it's selected Marker2D.
- Speed and the directed Marker can be changed from the Inspector of the AnimationPlayer.
- ColorRec and CollisionShape2D can be swapped out for whatever you wish to use, Tilemap is an option, whatever is inside the AnimatedBody2D 'Platform' will be moved with the animation.
- Animation by default has some easing, if you wish to remove the easing simply set Easing in Inspector of AnimationPlayer to 0 (0 is off).
- You can also change how long between moving, time at each station? with the Stopframe variable in the inspector, (0 is NO wait time).

FOR ACTIVATED PLATFORMS
- Repeat steps above, and use the additional options from the AnimationPlayer Inspector.
- There are 3 other options for activated platforms; "Move", "Hold2Move", "Hold2Open".
  - "Move" is run so that whenever activator is pressed, a full animation forward and back will play.
  - "Hold2Move" is run so that the platform will continuously play it's animation forward and back while the activator is pressed.
  - "Hold2Open" is run so that while the activator is pressed, the platform will be at it's marker position, and when button is not pressed, it will be at it's original position.
- Activator is used to set the activator for the platform, you can drag in a provided "ActivatorButton" scene into your level and link it via the platform. This will make it so that the button can control the platform animation.
- However the activator can be used as any Node2D, as long as that node provides a custom signal of 'activated' and 'deactivated', then it will still work correctly with the platform.
- ALSO, the "ActivatorButton" has the option to Mimic a button, this is a super handy feature if you want two separate buttons to power the same platforms.
  - But it also allows a button to mimic a button while also running a platform itself separately (it's easier to see if you just try the Demo scene)
  - Mimic Button is not required to have a connected sister button, don't connect unless you want it to mimic another button!

![alt text](https://github.com/LukeCGG/MovingPlatformsAnimatedEASY/blob/main/Inspector.png?raw=true)
![alt text](https://github.com/LukeCGG/MovingPlatformsAnimatedEASY/blob/main/Scene.png?raw=true)
![alt text](https://github.com/LukeCGG/MovingPlatformsAnimatedEASY/blob/main/inAction.png?raw=true)
