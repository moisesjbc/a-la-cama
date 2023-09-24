extends CenterContainer


var main
var is_game_over: bool = true


func start(main, is_game_over):
	self.main = main
	self.is_game_over = is_game_over
	if is_game_over:
		$panel/margin_container/vbox_container/title.text = "¡GAME OVER!"
		$panel/margin_container/vbox_container/restart_button.text = "REINTENTAR - [espacio]"
	else:
		$panel/margin_container/vbox_container/title.text = "¡DULCES SUEÑOS!"
		$panel/margin_container/vbox_container/restart_button.text = "SIGUIENTE NIVEL - [espacio]"
	$panel/margin_container/vbox_container/main_menu_button.visible = is_game_over
	get_tree().paused = true
	visible = true


func stop():
	get_tree().paused = false
	visible = false


func _on_restart_button_pressed():
	stop()
	if is_game_over:
		main.restart_level()
	else:
		main.next_level()


func _input(event):
	if visible and event is InputEventKey and not event.pressed and event.scancode == KEY_SPACE:
		_on_restart_button_pressed()


func _on_main_menu_button_pressed():
	stop()
	get_tree().change_scene("res://gui/menus/main_menu/main_menu.tscn")
