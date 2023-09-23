extends Node2D

signal player_reached_bed


func _on_bed_body_entered(body):
	emit_signal("player_reached_bed")


func get_player_spawn_position():
	return $fixed_elements/player_spawn_position.global_position


func get_fixed_elements_scale():
	return $fixed_elements.scale.x


func start(current_level):
	var fixed_elements_scale: int = 1
	if current_level % 2 == 1:
		fixed_elements_scale = -1

	$fixed_elements.scale.x = fixed_elements_scale
	for level_section in $level_sections.get_children():
		level_section.load_section(current_level, fixed_elements_scale)
