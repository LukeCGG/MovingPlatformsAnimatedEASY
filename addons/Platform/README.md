Want to make a 2D moving platform in Godot? YouTube tutorials too hard and restricting? You've come to the right place, it's never been more simple!

Tested on Godot 4.3 (But probably works on older and newer versions) -
Start by dropping the Platform scene into your Level
Right click it in the scene tree
Select Editable Children
Move the Marker2D and Boom! Moving Platforms!
FOR JUST PLATFORMS

Platforms by defualt are set to "Auto", this mean that they will start moving when the level is loaded.
Each platform will move independently from each other to it's selected Marker2D.
Speed and the directed Marker can be changed from the Inspector of the AnimationPlayer.
ColorRec and CollisionShape2D can be swapped out for whatever you wish to use, Tilemap is an option, whatever is inside the AnimatedBody2D 'Platform' will be moved with the animation.
Animation by default has some easing, if you wish to remove the easing simply set Easing in Inspector of AnimationPlayer to 0 (0 is off).
You can also change how long between moving, time at each station? with the Stopframe variable in the inspector, (0 is NO wait time).
FOR ACTIVATED PLATFORMS

Repeat steps above, and use the aditional options from the AnimationPlayer Inspector.
There are 3 other options for activated platforms; "Move", "Hold2Move", "Hold2Open".
"Move" is run so that whenever activator is pressed, a full aniamtion forward and back will play.
"Hold2Move" is run so that the platform will continiously play it's animation forward and back while the activator is pressed.
"Hold2Open" is run so that while the activator is pressed, the platform will be at it's marker position, and when button is not pressed, it will be at it's original position.
Activator is used to set the activator for the platform, you can drag in a provided "ActivatorButton" scene into your level and link it via the platform. This will make it so that the button can control the platform animation. However the activator can be used as any Node2D, as long as that node provides a custom signal of 'activated' and 'deactivated', then it will still work correctly with the platform.
