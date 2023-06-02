extends KinematicBody2D

export var move_speed := 100
export var jump_speed := 400
export var gravity := 1500
var velocity := Vector2.ZERO

func _physics_process(delta: float) -> void:
	# reset horizontal velocity
	velocity.x = 0

	# set horizontal velocity
	if Input.is_action_pressed("move_right"):
		velocity.x += move_speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= move_speed
	 # jump will happen on the next frame
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_speed # negative Y is up in Godot

	# apply gravity
	# player always has downward velocity
	velocity.y += gravity * delta

	# actually move the player
	velocity = move_and_slide(velocity, Vector2.UP)
