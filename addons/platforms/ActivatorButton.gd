extends Node2D

signal activated
signal deactivated

@export var mimicButton : Node2D

func _on_area_2d_body_entered(_body):
	#Add asset change on to here
	#$ColorRect.size.y = 4
	#print("Activated")
	if mimicButton:
		mimicButton.emit_signal("activated")
	emit_signal("activated")

func _on_area_2d_body_exited(_body):
	#Add asset change off to here
	#$ColorRect.size.y = 8
	#print("Deactivated")
	if mimicButton:
		mimicButton.emit_signal("deactivated")
	emit_signal("deactivated")
