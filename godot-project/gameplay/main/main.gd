extends Node


func _ready():
	$levels.player = $player
	$gui/time_counter.start(1)


func _on_moon_moon_collided():
	print("ON MOOD COLLIDED")
	$moon.restart()
	$levels._on_moon_moon_collided()
	


func _on_levels_player_reached_bed():
	$moon.fall()


func _on_player_player_died():
	$gui/game_over.start()



func _on_time_counter_time_ended():
	$moon.fall()
