extends Node2D


signal player_reached_bed


func _on_bed_body_entered(body):
	emit_signal("player_reached_bed")


func get_player_spawn_position():
	return $fixed_elements/player_spawn_position.global_position

func get_fixed_elements_scale():
	return $fixed_elements.scale.x

func load_level(fixed_elements_scale):
	$fixed_elements.scale.x = -fixed_elements_scale
