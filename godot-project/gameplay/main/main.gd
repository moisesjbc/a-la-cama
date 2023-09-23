extends Node


var player_reached_bed: bool = false
var current_level_index = 0




func _ready():
	restart_game()
	

func _on_moon_moon_collided():
	$front_gui/level_end_screen.start(self, not player_reached_bed)


func _on_levels_player_reached_bed():
	$moon.fall(true)


func _on_player_player_died():
	$front_gui/game_over.start()


func _on_time_counter_time_ended():
	$moon.fall(false)


func _on_level_player_reached_bed():
	player_reached_bed = true
	$moon.fall(true)


func start_level(level_index):
	current_level_index = level_index
	player_reached_bed = false
	$moon.restart()
	$level.start(current_level_index)
	$player.global_position = $level.get_player_spawn_position()
	$background_gui/time_counter.start(50)


func restart_game():
	start_level(0)


func next_level():
	start_level(current_level_index + 1)
