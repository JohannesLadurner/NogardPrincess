extends KinematicBody2D

onready var player = get_parent().get_node("Player")
var move_speed = 50
export var gravity := 1000
var velocity := Vector2.ZERO
var player_position
func _process(delta):
	player_position = player.position
	var target_position = (player.position - position).normalized()
	if position.distance_to(player.position) < 300:
		move_and_slide(target_position * move_speed)
	
	if player_position.x > position.x:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
