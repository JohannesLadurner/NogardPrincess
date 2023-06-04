extends KinematicBody2D

onready var player = get_parent().get_node("Player")
export var triggered = false

func _ready():
	$AnimatedSprite.play("dead")
	$AnimatedSprite.connect("animation_finished", self, "animation_finished")
	if !GlobalProperties.is_reverse:
		$Area2D/CollisionShape2D.disabled = true
		
	
func _process(delta):
	if !GlobalProperties.is_reverse:
		return
	
	if $AnimatedSprite.animation == "awake":
		return
	
	if position.x > player.position.x + 50 and !triggered:
		print("awake")
		$AnimatedSprite.play("awake")
		triggered = true
	

func animation_finished():
	if $AnimatedSprite.animation == "awake":
		$AnimatedSprite.play("idle")

