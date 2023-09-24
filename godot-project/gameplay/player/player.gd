extends KinematicBody2D

var GRAVITY
var SPEED = 500
var UP: Vector2
var JUMP_SPEED

var vertical_speed = 0

signal player_died
var player_died: bool = false


func restart():
	GRAVITY = 1000
	JUMP_SPEED = 600
	UP = Vector2(0, -1)
	$sprite.visible = true
	$z_particles.emitting = false
	player_died = false


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
	
	if not player_died and global_position.y < -64:
		player_died = true
		destroy()


func destroy():
	emit_signal("player_died")


func sleep():
	$sprite.visible = false
	$z_particles.emitting = true


func invert_gravity():
	GRAVITY *= -1
	JUMP_SPEED *= -1
	UP.y *= -1
