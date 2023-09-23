extends CenterContainer


var main
var is_game_over: bool = true


func start(main, is_game_over):
	self.main = main
	self.is_game_over = is_game_over
	if is_game_over:
		$panel/margin_container/vbox_container/title.text = "¡Game over!"
		$panel/margin_container/vbox_container/restart_button.text = "Nueva partida - [espacio]"
	else:
		$panel/margin_container/vbox_container/title.text = "¡Dulces sueños!"
		$panel/margin_container/vbox_container/restart_button.text = "Siguiente nivel - [espacio]"
	print("$panel/margin_container/vbox_container/title.text")
	get_tree().paused = true
	visible = true


func stop():
	get_tree().paused = false
	visible = false


func _on_restart_button_pressed():
	stop()
	if is_game_over:
		get_tree().change_scene("res://gameplay/main/main.tscn")
	else:
		main.next_level()


func _input(event):
	if visible and event is InputEventKey and not event.pressed and event.scancode == KEY_SPACE:
		_on_restart_button_pressed()
