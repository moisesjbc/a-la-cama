extends CenterContainer


func start():
	visible = true
	get_tree().paused = true


func stop():
	visible = false
	get_tree().paused = false


func _on_restart_button_pressed():
	stop()
	get_tree().change_scene("res://gameplay/main/main.tscn")


func _input(event):
	if visible and event is InputEventKey and not event.pressed and event.scancode == KEY_SPACE:
		_on_restart_button_pressed()
