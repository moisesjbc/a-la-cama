extends KinematicBody2D

export var GRAVITY: int = 1000
export var SPEED: int = 500
var UP: Vector2 = Vector2(0, -1)
export var JUMP_SPEED: int = 500

var vertical_speed = 0

signal player_died


func restart():
	print("Restart gravity? (" + str(GRAVITY) + "): " + str((GRAVITY < 0)))
	GRAVITY = 1000
	JUMP_SPEED = 500
	UP = Vector2(0, -1)
	$sprite.visible = true
	$z_particles.emitting = false


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


func destroy():
	emit_signal("player_died")


func sleep():
	$sprite.visible = false
	$z_particles.emitting = true


func invert_gravity():
	GRAVITY *= -1
	JUMP_SPEED *= -1
	UP.y *= -1
	print("GRAVITY INVERTED ", GRAVITY)
	print("JUMP_SPEED INVERTED ", JUMP_SPEED)
	print("UP INVERTED ", UP)


func _on_visibility_notifier_viewport_exited(viewport):
	destroy()
