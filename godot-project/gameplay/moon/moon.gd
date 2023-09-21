extends KinematicBody2D

export var SPEED: int = 50
export var MAX_SPEED: int = 500
var velocity: Vector2 = Vector2(0, SPEED)

signal moon_collided

func _process(delta):
	if velocity.y != 0:
		# Fall until crashing with the building roof
		var collision = move_and_collide(velocity * delta)
		if collision:
			emit_signal("moon_collided")
			restart()


func restart():
	# It's a new day! :-D
	if velocity.y > 0:
		velocity.y = -MAX_SPEED


func fall():
	velocity.y = MAX_SPEED


func _on_visibility_notifier_viewport_exited(viewport):
	velocity.y = SPEED
