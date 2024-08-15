Want to make a 2D moving platform in Godot? YouTube tutorials too hard and restricting? You've come to the right place, it's never been more simple!

1. Start by dropping the Platform scene into your Level
2. Right click it in the scene tree
3. Select Edit Children
4. Move the Marker2D and Boom! Moving Platforms!

FOR JUST PLATFORMS
- Each platform will move independently from each other.
- Speed and the directed Marker can be changed from the Inspector of the AnimationPlayer.
- ColorRec and CollisionShape2D can be swapped out for whatever you wish to use, Tilemap is an option, whatever is inside the AnimatedBody2D 'Platform' will be moved with the animation.
- Animation by default has some easing, if you wish to remove the easing simply set Easing in Inspector of AnimationPlayer to 0 (0 is off).
- You can also change how long between moving, time at each station? with the Stopframe variable in the inspector, (0 is NO wait time).

FOR ACTIVATED PLATFORMS
- Repeat steps above, and use the aditional options from the AnimationPlayer Inspector.
- Auto Start will make the platform a "non activated" platform and it will play it's animation back and forth uninterupted.
- Loop will make the platform loops it's animation, (NOTE: It is reccomended not to turn off loop and Autostart together, as it will not reactivate once activated once.)
- Activator is used to set the activator for the platform, you can drag in a provided "ActivatorButton" scene into your level and link it via the platform. This will make it so that the button can control the platform animtion.
  - If Loop is off, activiting the button will make the platform do a full loop of it's animation once per click (When not playing).
  - If Loop is on, pressing the button will move the platform while pressed and pause it's position when deactivated.
