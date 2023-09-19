extends KinematicBody2D

export var GRAVITY: int = 1000
export var SPEED: int = 500
const UP: Vector2 = Vector2(0, -1)
export var JUMP_SPEED: int = 500

var vertical_speed = 0

func _physics_process(delta):
	var velocity: Vector2 = Vector2.ZERO

	# Vertical movement
	vertical_speed += GRAVITY * delta
	if is_on_floor():
		vertical_speed = 0
		if Input.is_action_just_pressed("ui_jump"):
			vertical_speed = -JUMP_SPEED
	velocity.y = vertical_speed

	# Horizontal movement
	velocity.x = 0
	if Input.is_action_pressed("ui_left"):
		velocity.x -= SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x += SPEED

	# Apply movement
	move_and_slide(velocity, UP)
