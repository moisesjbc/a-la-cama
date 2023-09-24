extends Node


var player_reached_bed: bool = false
var current_level_index = 0


func _ready():
	restart_game()


func _on_moon_moon_collided():
	$front_gui/level_end_screen.start(self, not player_reached_bed)


func _on_player_player_died():
	$front_gui/game_over.start(self)


func _on_time_counter_time_ended():
	$moon.fall(types.MoonMood.ANGRY)


func _on_level_player_reached_bed():
	player_reached_bed = true
	var moon_mood = types.MoonMood.HAPPY
	if is_last_level():
		moon_mood = types.MoonMood.LOVE
	$moon.fall(moon_mood)


func start_level(level_index):
	var is_different_level = current_level_index != level_index
	current_level_index = level_index
	player_reached_bed = false
	$front_gui/level_counter.text = str(current_level_index + 1) + " / " + str($level.n_levels)
	$player.restart()
	$moon.restart()
	if is_different_level:
		$level.start(current_level_index)
	$player.global_position = $level.get_player_spawn_position()
	$background_gui/time_counter.start(10)


func restart_game():
	start_level(0)


func restart_level():
	start_level(current_level_index)


func next_level():
	start_level(current_level_index + 1)


func _input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE and not event.pressed:
		$front_gui/pause_menu.start()

func is_last_level():
	return (current_level_index + 1) == $level.n_levels
