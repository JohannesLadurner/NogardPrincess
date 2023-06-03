extends KinematicBody2D

export var move_speed := 100
export var jump_speed := 350
export var gravity := 1000
export var health := 1
onready var area := get_node("Area2D")
var enemy
var velocity := Vector2.ZERO
onready var end = get_parent().get_node("End")
onready var start = get_parent().get_node("Start")
var attack_timer = Timer.new()
var attack_delay = 100
var readyToAttack = true

func _ready():
	$AnimatedSprite.play("idle")
	$AnimatedSprite.connect("animation_finished", self, "animation_finished")
	area.connect("area_enter", self, "_on_collision")
	attack_timer.connect("timeout",self,"attack_delay_resetted")
	attack_timer.wait_time = 3
	attack_timer.one_shot = true
	add_child(attack_timer)

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
			
	if position.x < end.position.x && GlobalProperties.is_reverse:
		changeSceneReverse()
	elif position.x > start.position.x && !GlobalProperties.is_reverse:
		changeSceneForward()

	if Input.is_action_pressed("attack"):
		attack()
		
	# apply gravity
	# player always has downward velocity
	velocity.y += gravity * delta

	# actually move the player
	velocity = move_and_slide(velocity, Vector2.UP)
	print(health)

func _process(delta: float) -> void:
	change_animation()

func change_animation():
	if $AnimatedSprite.animation == "attack":
		return
	# face left or right
	if velocity.x > 0:
		$AnimatedSprite.flip_h = GlobalProperties.is_reverse
		$RightCollisionShape.disabled = !GlobalProperties.is_reverse
		$LeftCollisionShape.disabled = GlobalProperties.is_reverse
		$Area2D/RightAreaCollision.disabled = GlobalProperties.is_reverse
		$Area2D/LeftAreaCollision.disabled = !GlobalProperties.is_reverse
	elif velocity.x < 0:
		$AnimatedSprite.flip_h = !GlobalProperties.is_reverse
		$RightCollisionShape.disabled = GlobalProperties.is_reverse
		$LeftCollisionShape.disabled = !GlobalProperties.is_reverse
		$Area2D/RightAreaCollision.disabled = !GlobalProperties.is_reverse
		$Area2D/LeftAreaCollision.disabled = GlobalProperties.is_reverse
	if velocity.y < 0: # negative Y is up
		$AnimatedSprite.play("jumpUp")
	elif velocity.y > 0:
		$AnimatedSprite.play("jumpDown")
	else:
		if velocity.x != 0:
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("idle")
			
func changeSceneForward():
	if get_tree().get_current_scene().get_name() == "DragonRoom":
		GlobalProperties.is_reverse = true
		get_tree().change_scene("res://assets/levels/Level01.tscn")
	
func changeSceneReverse():
	if get_tree().get_current_scene().get_name() == "Level01": 
		get_tree().change_scene("res://assets/levels/Level02.tscn")
	elif get_tree().get_current_scene().get_name() == "Level02": 
		get_tree().change_scene("res://assets/levels/Level03.tscn")
	elif get_tree().get_current_scene().get_name() == "Level03": 
		get_tree().change_scene("res://assets/levels/Level4.tscn")
	elif get_tree().get_current_scene().get_name() == "Level4": 
		get_tree().change_scene("res://assets/levels/Level05.tscn")
	elif get_tree().get_current_scene().get_name() == "Level05": 
		get_tree().change_scene("res://assets/levels/Level06.tscn")
	elif get_tree().get_current_scene().get_name() == "Level06": 
		get_tree().change_scene("res://assets/levels/Level06.tscn")
	elif get_tree().get_current_scene().get_name() == "DragonRoom": 
		get_tree().change_scene("res://assets/levels/Level01.tscn")

func attack():
	if $AnimatedSprite.animation == "attack":
		return
	$AnimatedSprite.play("attack")
	for enemy in get_node("Area2D").get_overlapping_areas():
		enemy.get_parent().get_damage()
		
func animation_finished():
	if $AnimatedSprite.animation == "attack":
		$AnimatedSprite.play("idle")

