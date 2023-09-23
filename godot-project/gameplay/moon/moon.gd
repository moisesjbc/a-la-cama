extends Sprite

export var SPEED: int = 3000
var velocity: Vector2 = Vector2(0, 0)
onready var initial_global_position = global_position

signal moon_collided


func _process(delta):
	if velocity.y != 0:
		# Fall until filling the screen.
		global_position.y += velocity.y * delta
		if global_position.y >= (get_rect().size.y / 2):
			global_position.y = (get_rect().size.y / 2)
			velocity.y = 0
			$particles.emitting = false
			emit_signal("moon_collided")


func restart():
	# It's a new day! :-D
	global_position = initial_global_position


func fall():
	$particles.emitting = true
	velocity.y = SPEED
