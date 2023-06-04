extends KinematicBody2D

onready var player = get_parent().get_node("Player")
export var triggered = false

func _ready():
	if GlobalProperties.endGame:
		$AnimatedSprite.play("idle")
		get_parent().get_node("Fairy").visible = false
		get_parent().get_node("Speechbubble/Label").visible = false
		get_parent().get_node("Speechbubble").visible = false
		return
	$AnimatedSprite.play("dead")
	$AnimatedSprite.connect("animation_finished", self, "animation_finished")
	if !GlobalProperties.is_reverse:
		$Area2D/CollisionShape2D.disabled = true
		
	
func _process(delta):
	if GlobalProperties.endGame:
		return
		
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

