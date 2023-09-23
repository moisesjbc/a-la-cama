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


func load_section(current_level_index, fixed_elements_scale):
	if $alternative.get_child(0) != null:
		$alternative.get_child(0).queue_free()

	var valid_alternatives = []
	for alternative in alternatives:
		if current_level_index >= alternative["first_level"]:
			valid_alternatives.append(alternative)
	randomize()
	if len(valid_alternatives):
		var current_alternative_index = randi() % len(valid_alternatives)
		var current_alternative = valid_alternatives[current_alternative_index]
		print("ENABLING current_alternative_index ", current_alternative_index)
		var alternative_scene = load("res://gameplay/level_section/alternatives/" + current_alternative["scene_name"] + ".tscn").instance()
		alternative_scene.scale.x = fixed_elements_scale
		$alternative.add_child(alternative_scene)
