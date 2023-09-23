extends Node2D

signal player_reached_bed


var alternative_defs = [
	{
		"scene_name": "a0",
		"first_level": 1
	},
	{
		"scene_name": "a1",
		"first_level": 2
	},
	{
		"scene_name": "a2",
		"first_level": 3
	},
	{
		"scene_name": "a3",
		"first_level": 4
	}
]
var valid_alternatives = []


func update_valid_alternatives(current_level_index):
	while len(alternative_defs) and (current_level_index >= alternative_defs[0]["first_level"]):
		var alternative_def = alternative_defs.pop_front()
		var alternative_scene = load("res://gameplay/level_section/alternatives/" + alternative_def["scene_name"] + ".tscn")
		valid_alternatives.append(alternative_scene)


func _on_bed_body_entered(body):
	emit_signal("player_reached_bed")


func get_player_spawn_position():
	return $fixed_elements/player_spawn_position.global_position


func get_fixed_elements_scale():
	return $fixed_elements.scale.x


func start(current_level_index):
	var fixed_elements_scale: int = 1
	if current_level_index % 2 == 1:
		fixed_elements_scale = -1

	update_valid_alternatives(current_level_index)

	$fixed_elements.scale.x = fixed_elements_scale
	for level_section in $level_sections.get_children():
		level_section.load_section(valid_alternatives, current_level_index, fixed_elements_scale)
