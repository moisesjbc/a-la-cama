extends Node


func _ready():
	$levels.player = $player


func _on_moon_moon_collided():
	$moon.restart()
	$levels._on_moon_moon_collided()
	


func _on_levels_player_reached_bed():
	$moon.fall()


func _on_player_player_died():
	$gui/game_over.start()
