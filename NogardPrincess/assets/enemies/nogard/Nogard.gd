extends KinematicBody2D

onready var player = get_parent().get_node("Player")
var health = 0
func _ready():
	$AnimatedSprite.play("dead")
	
func _process(delta):
	if player.is_reverse:
		if health >= 10:
			$AnimatedSprite.play("idle")

func get_damage():
	if player.is_reverse:
		health += 1
