extends CenterContainer


func start():
	get_tree().paused = true
	visible = true


func stop():
	get_tree().paused = false
	visible = false


func _on_resume_game_button_pressed():
	stop()


func _input(event):
	if event is InputEventKey and (event.scancode == KEY_SPACE) and not event.pressed:
		_on_resume_game_button_pressed()


func _on_main_menu_button_pressed():
	stop()
	get_tree().change_scene("res://gui/menus/main_menu/main_menu.tscn")
