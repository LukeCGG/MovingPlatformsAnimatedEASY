extends AnimationPlayer
class_name Rotator
## Provided with Sweat & Tears by LukeCGG [br]
## Easily Animate Moving Platforms in 2D with just a click and a Drag

#Create a new animation
var animation = Animation.new()

#Variables to set defaults
@export_enum("Auto", "Move", "Hold2Move", "Hold2Open") var type = "Auto" ## "Auto" moves when contoniously when loaded.[br]"Move" does one full movement on activation.[br]"Hold2Move" will only move when activator is held and will stop in mid motion if released.[br]"Hold2Open" will move to marker when activator held, and move to original position when released.
@export var activator : Node2D ## The Node providing Activate and Deactivate Signals.[br]Use "ActivatorButton" as a template if you need.
@export var speed : float = 0.5 ## The speed at which the platform moves
@onready var marky = $"../../RotateLocation" # Default Marker2D
@export var marker : Marker2D ## ONLY CHANGE VALUE IF YOU WANT TO USE A DIFFERENT MARKER[br]The Marker2D which the platform will move to.
@export var stopframe : float = 0.1 ## How long the platform will wait at each end before continuing loop
@export var easing : float = 1 ## How smooth to ease platform between locations

var willLoop = false

#Unique name for animation to not interfear with duplicates
@onready var nameMe = str($"../..".name) + str(randi_range(10,99))

#CHANGED: Defaults for animation now use rotation value
var node_path = NodePath('Platforms:rotation')
var track_type = Animation.TYPE_VALUE
var anim = get_animation_library("Platforms")

#Once loaded, run!
func _ready():
	#Set Marker if null
	if not marker:
		marker = marky
	#Seat easing with a more user frienly layout
	if easing <= -1:
		easing = 0
		print("You can't divide by 0!!")
	var easingset = easing + 1
	
	if type == "Hold2Open":
		#Animation setup
		animation.add_track(track_type)
		animation.track_set_path(0, node_path)
		animation.length = 2
		var track_idx = animation.find_track(node_path, track_type)
		if track_idx != -1:
			#CHANGED: New rotation and start_rotation use global rotation values instead
			
			var edge = stopframe
			var time_of_keyframe = 1
			var new_rotation = marker.global_rotation
			var start_rotation = $"..".global_rotation
			
			# CHANGED: Easing of rotations uses float instead of Vector2 Values
			animation.track_insert_key(track_idx, edge, 0, 1 * easingset) # Start
			animation.track_insert_key(track_idx, animation.length - edge, new_rotation - start_rotation) # End
			
			#Set Animation Speed
			speed_scale = speed
			#Actually make the Animation
			anim.add_animation(nameMe, animation)
		else:
			#Something went wrong, (Hopefully this never happens!)
			print("Track not found.")
		activator.activated.connect(_activated)
		activator.deactivated.connect(_deactivated)
	else:
		#Animation setup
		animation.add_track(track_type)
		animation.track_set_path(0, node_path)
		animation.length = 4
		if type == "Auto" or type == "Hold2Move":
			willLoop = true
			animation.loop = true
		var track_idx = animation.find_track(node_path, track_type)
		
		# CHANGED: New rotation and start_rotation use global rotation values instead
		if track_idx != -1:
			var edge = stopframe
			var time_of_keyframe = 1
			var new_rotation = marker.global_rotation
			var start_rotation = $"..".global_rotation
			
			print("Start Rotation is " + str(start_rotation))
			print("New Rotation is " + str(new_rotation))
			
			# CHANGED: Easing of rotations uses float instead of Vector2 Values
			animation.track_insert_key(track_idx, edge, 0, 1 * easingset) # Start
			animation.track_insert_key(track_idx, animation.length - edge, new_rotation - start_rotation) # End
			
			for i in animation.track_get_key_count(track_idx):
				print("Animation track value is " + str(animation.track_get_key_value(track_idx, i)))
			
			#Set Animation Speed
			speed_scale = speed
			#Actually make the Animation
			anim.add_animation(nameMe, animation)
			#Play the Animation (Or set activators)
			if type == "Auto":
				play('Platforms/' + str(nameMe))
				print("Current Animation playing is " + str(current_animation))
			else:
				activator.activated.connect(_activated)
				activator.deactivated.connect(_deactivated)
		else:
			#Something went wrong, (Hopefully this never happens!)
			print("Track not found.")
		
#Button Pressed
func _activated():
	#print("SIGNAL ACTIVE")
	if type == "Hold2Open":
		play('Platforms/' + str(nameMe))
	else:
		if willLoop == true and is_playing():
			pass
		else:
			play('Platforms/' + str(nameMe))
	
#Button released
func _deactivated():
	#print("SIGNAL DEACTIVE")
	if type == "Hold2Open":
		play_backwards('Platforms/' + str(nameMe))
	else:
		if willLoop == true:
			pause()
	
