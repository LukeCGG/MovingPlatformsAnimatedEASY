extends Node2D

signal activated
signal deactivated

func _on_area_2d_body_entered(_body):
	#Add asset change on to here
	#$ColorRect.size.y = 4
	#print("Activated")
	emit_signal("activated")

func _on_area_2d_body_exited(_body):
	#Add asset change off to here
	#$ColorRect.size.y = 8
	#print("Deactivated")
	emit_signal("deactivated")
