extends Node2D

signal activated
signal deactivated

var takenover = false

@export var mimicButton : Node2D

func _on_area_2d_body_entered(_body):
	if takenover:
		pass
	else:
		#Add asset change on to here
		#$ColorRect.size.y = 4
		#print("Activated")
		if mimicButton:
			mimicButton.takenover = true
			mimicButton.emit_signal("activated")
		emit_signal("activated")

func _on_area_2d_body_exited(_body):
	if takenover:
		pass
	else:
		#Add asset change off to here
		#$ColorRect.size.y = 8
		#print("Deactivated")
		if mimicButton:
			mimicButton.takenover = false
			mimicButton.emit_signal("deactivated")
		emit_signal("deactivated")
