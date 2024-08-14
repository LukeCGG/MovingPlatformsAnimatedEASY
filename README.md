Make a 2D moving platform in Godot in seconds! Drop the Platform scene into your Level, Right click, Select Edit Children, Move the marker and Boom! Moving Platforms!
Each platform will move independently from each other. Speed and the directed Marker can be changed from the Inspector of the AnimationPlayer.
ColorRec and CollisionShape2D can be swapped out for whatever you wish to use, Tilemap is an option, whatever is inside the AnimatedBody2D 'Platform' will be moved with the animation.
Animation by default has some easing, if you wish to remove the easing simply set Easing in Inspector of AnimationPlayer to 0 (0 is off)
You can also change how long between moving, time at each station? with the Stopframe variable in the inspector, (0 is NO wait time)
