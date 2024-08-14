extends AnimationPlayer
#Provided with Sweat & Tears by LukeCGG

#Create a new animation
var animation = Animation.new()

#Variables to set defaults
@export var Speed : float = 0.5
@onready var marky = $"../../Marker2D"
@export var marker : Marker2D = marky
@export var stopframe : float = 0.1
@export var easing : float = 1

#Defaults for new Animation
var node_path = NodePath('Platform:position')
var track_type = Animation.TYPE_VALUE
var anim = get_animation_library("Platforms")

#Once loaded, run!
func _ready():
	#Seat easing with a more user frienly layout
	if easing <= -1:
		easing = 0
		print("You can't divide by 0!!")
	var easingset = easing + 1
	#Unique name for animation to not interfear with duplicates
	var nameMe = str($"../..".name) + str(randi_range(0,100))
	
	#Animation setup
	animation.add_track(track_type)
	animation.track_set_path(0, node_path)
	animation.length = 4
	animation.loop = true
	var track_idx = animation.find_track(node_path, track_type)
	if track_idx != -1:
		var edge = stopframe
		var time_of_keyframe = 2
		var new_position = marker.global_position
		var start_pos = $"..".global_position
		#print(start_pos, " ", new_position)
		#Easing of positions
		animation.track_insert_key(track_idx, edge, Vector2(0,0), 1 * easingset)
		animation.track_insert_key(track_idx, animation.length - edge, Vector2(0,0))
		animation.track_insert_key(track_idx, 1, Vector2((new_position.x - start_pos.x) / 2, (new_position.y - start_pos.y) / 2), 1 / easingset)
		animation.track_insert_key(track_idx, 3, Vector2((new_position.x - start_pos.x) / 2, (new_position.y - start_pos.y) / 2), 1 / easingset)
		animation.track_insert_key(track_idx, time_of_keyframe - edge, Vector2(new_position.x - start_pos.x, new_position.y - start_pos.y))
		animation.track_insert_key(track_idx, time_of_keyframe + edge, Vector2(new_position.x - start_pos.x, new_position.y - start_pos.y), 1 * easingset)
		
		#Set Animation Speed
		speed_scale = Speed
		#Actually make the Animation
		anim.add_animation(nameMe, animation)
		#Play the Animation
		play('Platforms/' + str(nameMe))
	else:
		#Something went wrong, (Hopefully this never happens!)
		print("Track not found.")
