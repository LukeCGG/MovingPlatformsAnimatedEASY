extends AnimationPlayer

var animation = Animation.new()

@export var Speed : float = 0.5
@onready var marky = $"../../Marker2D"
@export var marker : Marker2D = marky

var node_path = NodePath('Platform:position')
var track_type = Animation.TYPE_VALUE
var anim = get_animation_library("Platforms")

func _ready():
	var nameMe = $"../..".name
	animation.add_track(track_type)
	animation.track_set_path(0, node_path)
	animation.length = 4
	animation.loop = true
	var track_idx = animation.find_track(node_path, track_type)
	if track_idx != -1:
		var edge = 0.1
		var time_of_keyframe = 2
		var new_position = marker.global_position
		var start_pos = $"..".global_position
		print(start_pos, " ", new_position)
		animation.track_insert_key(track_idx, edge, Vector2(0,0), 2)
		animation.track_insert_key(track_idx, animation.length - edge, Vector2(0,0))
		animation.track_insert_key(track_idx, 1, Vector2((new_position.x - start_pos.x) / 2, (new_position.y - start_pos.y) / 2), 0.5)
		animation.track_insert_key(track_idx, 3, Vector2((new_position.x - start_pos.x) / 2, (new_position.y - start_pos.y) / 2), 0.5)
		animation.track_insert_key(track_idx, time_of_keyframe - edge, Vector2(new_position.x - start_pos.x, new_position.y - start_pos.y))
		animation.track_insert_key(track_idx, time_of_keyframe + edge, Vector2(new_position.x - start_pos.x, new_position.y - start_pos.y), 2)
		speed_scale = Speed
		anim.add_animation(nameMe, animation)
		play('Platforms/' + str(nameMe))
	else:
			print("Track not found.")
