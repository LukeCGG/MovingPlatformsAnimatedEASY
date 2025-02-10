extends AnimationPlayer
## Provided with Sweat & Tears by LukeCGG [br]
## Easily Animate Moving Platforms in 2D with just a click and a Drag

#Create a new animation
var animation = Animation.new()

#Variables to set defaults
@export_enum("Auto", "Move", "Hold2Move", "Hold2Open") var type = "Auto" ## "Auto" moves when contoniously when loaded.[br]"Move" does one full movement on activation.[br]"Hold2Move" will only move when activator is held and will stop in mid motion if released.[br]"Hold2Open" will move to marker when activator held, and move to original position when released.
@export var activator : Node2D ## The Node providing Activate and Deactivate Signals.[br]Use "ActivatorButton" as a template if you need.
@export var speed : float = 0.5 ## The speed at which the platform moves
@onready var marky = $"../../MoveLocation" # Default Marker2D
@export var marker : Marker2D ## ONLY CHANGE VALUE IF YOU WANT TO USE A DIFFERENT MARKER[br]The Marker2D which the platform will move to.
@export var stopframe : float = 0.1 ## How long the platform will wait at each end before continuing loop
@export var easing : float = 1 ## How smooth to ease platform between locations

var willLoop = false

#Unique name for animation to not interfear with duplicates
@onready var nameMe = str($"../..".name) + str(randi_range(10,99))

#Defaults for new Animation
var anim = get_animation_library("Platforms")

#Once loaded, run!
func _ready():
	#Set Marker if null
	if not marker:
		marker = marky
	#Set easing with a more user frienly layout
	if easing <= -1:
		easing = 0
		print("You can't divide by 0!!")
	var easingset = easing + 1
	
	#Animation pre-setup
	var position_track_index = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(position_track_index, "Platform:position")
	var rotation_track_index = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(rotation_track_index, "Platform:rotation")
	
	if type == "Hold2Open":
		#Animation setup
		animation.length = 2
		if position_track_index != -1 and rotation_track_index != -1:
			var edge = stopframe
			var time_of_keyframe = 1
			var new_position = marker.global_position
			var start_pos = $"..".global_position
			var new_rotation = marker.rotation
			var start_rot = $"..".rotation
			
			#print(start_pos, " ", new_position)
			#Easing of positions
			animation.track_insert_key(position_track_index, edge, Vector2(0,0), 1 * easingset) #Start
			animation.track_insert_key(position_track_index, 1, Vector2((new_position.x - start_pos.x) / 2, (new_position.y - start_pos.y) / 2), 1 / easingset) #Center
			animation.track_insert_key(position_track_index, animation.length - edge, Vector2(new_position.x - start_pos.x, new_position.y - start_pos.y)) #End
			
			#print(start_rot, " ", new_rotation)
			#Easing roations
			animation.track_insert_key(rotation_track_index, edge, 0.0, 1 * easingset) # Start
			animation.track_insert_key(rotation_track_index, 1, int((new_rotation - start_rot) / 2), 1 / easingset) # Center
			animation.track_insert_key(rotation_track_index, animation.length - edge, int(new_rotation - start_rot)) # End
			
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
		animation.length = 4
		if type == "Auto" or type == "Hold2Move":
			willLoop = true
			animation.loop = true
		if position_track_index != -1 and rotation_track_index != -1:
			var edge = stopframe
			var time_of_keyframe = 2
			var new_position = marker.global_position
			var start_pos = $"..".global_position
			var new_rotation = marker.global_rotation
			var start_rot = $"..".global_rotation
			
			#print(start_pos, " ", new_position)
			#Easing of positions
			animation.track_insert_key(position_track_index, edge, Vector2(0,0), 1 * easingset)
			animation.track_insert_key(position_track_index, animation.length - edge, Vector2(0,0))
			animation.track_insert_key(position_track_index, 1, Vector2((new_position.x - start_pos.x) / 2, (new_position.y - start_pos.y) / 2), 1 / easingset)
			animation.track_insert_key(position_track_index, 3, Vector2((new_position.x - start_pos.x) / 2, (new_position.y - start_pos.y) / 2), 1 / easingset)
			animation.track_insert_key(position_track_index, time_of_keyframe - edge, Vector2(new_position.x - start_pos.x, new_position.y - start_pos.y))
			animation.track_insert_key(position_track_index, time_of_keyframe + edge, Vector2(new_position.x - start_pos.x, new_position.y - start_pos.y), 1 * easingset)
			
			#print(start_rot, " ", new_rotation)
			#Easing roations
			animation.track_insert_key(rotation_track_index, edge, 0, 1 * easingset)
			animation.track_insert_key(rotation_track_index, animation.length - edge, 0)
			animation.track_insert_key(rotation_track_index, 1, (new_rotation - start_rot) / 2, 1 / easingset)
			animation.track_insert_key(rotation_track_index, 3, (new_rotation - start_rot) / 2, 1 / easingset)
			animation.track_insert_key(rotation_track_index, time_of_keyframe - edge, new_rotation - start_rot)
			animation.track_insert_key(rotation_track_index, time_of_keyframe + edge, new_rotation - start_rot, 1 * easingset)
			
			#Set Animation Speed
			speed_scale = speed
			#Actually make the Animation
			anim.add_animation(nameMe, animation)
			#Play the Animation (Or set activators)
			if type == "Auto":
				play('Platforms/' + str(nameMe))
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
