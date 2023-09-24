extends Node

signal player_reached_bed
export var enforced_alternative_scene_name: String = ""

var current_level_index

var n_levels = 17
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
		"first_level": 5
	},
	{
		"scene_name": "a4",
		"first_level": 7
	},
	{
		"scene_name": "a5",
		"first_level": 9
	},
	{
		"scene_name": "a6",
		"first_level": 11
	},
	{
		"scene_name": "a7",
		"first_level": 13
	},
	{
		"scene_name": "a8",
		"first_level": 15
	}
]
var valid_alternatives = []

var tutorial_texts = {
	"0": "Bienvenido a \"¡A la cama!\"\nUsa las flechas o A/D para moverte hacia los lados y llegar hasta la cama\nantes de que se acabe el tiempo (barra superior)",
	"1": "Parece que aquí CAE LA NOCHE literalmente.\nEn fin, esos pinchos parecen peligrosos. Pulsa ESPACIO para saltar",
	"7": "Toca la plataforma para invertir la gravedad.\n¡Cuidado con salir volando!"
}

func update_valid_alternatives(current_level_index):
	var includes_new_alternative = false
	while len(alternative_defs) and (current_level_index >= alternative_defs[0]["first_level"]):
		includes_new_alternative = true
		var alternative_def = alternative_defs.pop_front()
		var alternative_scene = load("res://gameplay/level_section/alternatives/" + alternative_def["scene_name"] + ".tscn")
		valid_alternatives.append(alternative_scene)
	return includes_new_alternative


func _on_bed_body_entered(body):
	body.sleep()
	$fixed_elements/bed.visible = false
	$fixed_elements/bed/bed_reached.play()
	emit_signal("player_reached_bed")


func get_player_spawn_position():
	return $fixed_elements/player_spawn_position.global_position


func get_fixed_elements_scale():
	return $fixed_elements.scale.x


func start(current_level_index):
	self.current_level_index = current_level_index
	$fixed_elements/bed.visible = true
	var fixed_elements_scale: int = 1
	if current_level_index % 2 == 1:
		fixed_elements_scale = -1

	var includes_new_alternative = false
	if enforced_alternative_scene_name == "":
		includes_new_alternative = update_valid_alternatives(current_level_index)
	else:
		valid_alternatives = [load("res://gameplay/level_section/alternatives/" + enforced_alternative_scene_name + ".tscn")]

	$fixed_elements.scale.x = fixed_elements_scale
	var middle_index = 0
	if len(valid_alternatives) > 1:
		middle_index = len(valid_alternatives) / 2
	if includes_new_alternative:
		$level_sections.get_child(0).load_section([valid_alternatives[len(valid_alternatives) - 1]], current_level_index, fixed_elements_scale)
	else:
		# Select between the latest added sections.
		$level_sections.get_child(0).load_section(valid_alternatives.slice(middle_index, len(valid_alternatives) - 1), current_level_index, fixed_elements_scale)
	$level_sections.get_child(1).load_section(valid_alternatives, current_level_index, fixed_elements_scale)
		
func restart(current_level_index):
	var tutorial_text = tutorial_texts.get(str(current_level_index))
	if tutorial_text != null:
		$center_container/tutorial_label.visible = true
		$center_container/tutorial_label.text = tutorial_text
	else:
		$center_container/tutorial_label.visible = false

func contains_tutorial():
	return tutorial_texts.get(str(current_level_index))
