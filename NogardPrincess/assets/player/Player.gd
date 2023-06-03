extends KinematicBody2D

export var move_speed := 100
export var jump_speed := 350
export var gravity := 1000
export var health := 1
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
	print(health)

func _process(delta: float) -> void:
	change_animation()

func change_animation():
	# face left or right
	if velocity.x > 0:
		$AnimatedSprite.flip_h = true
		$RightCollisionShape.disabled = false
		$LeftCollisionShape.disabled = true
	elif velocity.x < 0:
		$AnimatedSprite.flip_h = false
		$RightCollisionShape.disabled = true
		$LeftCollisionShape.disabled = false
	if velocity.y < 0: # negative Y is up
		$AnimatedSprite.play("jumpUp")
	elif velocity.y > 0:
		$AnimatedSprite.play("jumpDown")
	else:
		if velocity.x != 0:
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("idle")
