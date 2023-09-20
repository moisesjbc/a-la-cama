extends Node2D

onready var level_scene = preload("res://gameplay/level/level.tscn")
onready var distance_between_levels: int = get_child(1).position.y - get_child(0).position.y
var level_distance = 0
export var LEVEL_CHANGING_SPEED: int = 700
var player


func _ready():
	get_child(0).connect("player_reached_bed", self, "next_level")


func next_level():
	player.visible = false
	get_child(0).disconnect("player_reached_bed", self, "next_level")
	
	# Load next level
	get_child(1).load_level(get_child(0).get_fixed_elements_scale())
	
	# Create a new level on the "backlog"
	var new_level = level_scene.instance()
	add_child(new_level)
	new_level.position.y = get_child(2).position.y + distance_between_levels

	# Destroy top level
	get_child(0).queue_free()
	
	# Start levels movement by setting a distance for moving them.
	level_distance = distance_between_levels


func _process(delta):
	if level_distance > 0:
		var offset = min(LEVEL_CHANGING_SPEED * delta, level_distance)
		level_distance -= offset
		translate(Vector2(0, -offset))
		if level_distance == 0:
			player.global_position = get_child(0).get_player_spawn_position()
			player.visible = true
			get_child(0).connect("player_reached_bed", self, "next_level")
