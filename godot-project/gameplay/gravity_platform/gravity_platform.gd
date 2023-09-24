extends Area2D


func _ready():
	$arrow_sprite/animation_player.play("arrow_movement")


func _on_gravity_platform_body_entered(body):
	if body.name == "player":
		body.invert_gravity()
