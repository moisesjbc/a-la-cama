extends Sprite

export var SPEED: int = 10
export var MAX_SPEED: int = 3000
var velocity: Vector2 = Vector2(0, 0)

signal moon_collided

func _process(delta):
	if velocity.y != 0:
		# Fall until crashing with the building roof
		global_position.y += velocity.y * delta
		print("global_position.y ", global_position.y)
		if global_position.y >= (get_rect().size.y / 2):
			global_position.y = (get_rect().size.y / 2)
			velocity.y = 0
			$particles.emitting = false
		#if collision:
		#	print(collision.collider.name)
		#	emit_signal("moon_collided")
		#	restart()


func restart():
	# It's a new day! :-D
	if velocity.y > 0:
		velocity.y = -MAX_SPEED


func fall():
	$particles.emitting = true
	velocity.y = MAX_SPEED
