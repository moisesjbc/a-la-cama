extends Node2D

var alternatives = [
	{
		"scene_name": "a0",
		"first_level": 0
	},
	{
		"scene_name": "a1",
		"first_level": 0
	}
]


func load_section(valid_alternatives, current_level_index, fixed_elements_scale):
	if $alternative.get_child(0) != null:
		$alternative.get_child(0).queue_free()

	if len(valid_alternatives):
		var current_alternative_index = randi() % len(valid_alternatives)
		var alternative_scene = valid_alternatives[current_alternative_index].instance()
		alternative_scene.scale.x = fixed_elements_scale
		$alternative.add_child(alternative_scene)
