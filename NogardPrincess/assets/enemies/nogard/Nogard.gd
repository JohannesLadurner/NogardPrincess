extends KinematicBody2D

var health = 0
func _ready():
	$AnimatedSprite.play("dead")
	if !GlobalProperties.is_reverse:
		$CollisionShape2D.disabled = true
		$Area2D/CollisionShape2D.disabled = true
		
	
func _process(delta):
	if !GlobalProperties.is_reverse:
		if health >= 10:
			$AnimatedSprite.play("idle")

func get_damage():
	if !GlobalProperties.is_reverse:
		health += 1
