extends KinematicBody2D

onready var player = get_parent().get_node("Player")
var move_speed = 30
export var gravity := 3000
var velocity := Vector2.ZERO
export var triggered = false
var health := 1
var color
var attack_timer = Timer.new()
var attack_delay = 100
var readyToAttack = true

func _ready():
	if get_tree().get_current_scene().get_name() == "Level01" or get_tree().get_current_scene().get_name() == "Level02": 
		color = "pink"
	if get_tree().get_current_scene().get_name() == "Level03" or get_tree().get_current_scene().get_name() == "Level4":
		color = "red"
	if get_tree().get_current_scene().get_name() == "Level05" or get_tree().get_current_scene().get_name() == "Level06":
		color = "purple"
	
	if GlobalProperties.is_reverse:
		$AnimatedSprite.play(color +"_dead")
	else:
		$AnimatedSprite.play(color +"_idle")
	$AnimatedSprite.connect("animation_finished", self, "animation_finished")
	attack_timer.connect("timeout",self,"attack_delay_resetted")
	attack_timer.wait_time = 3
	attack_timer.one_shot = true
	add_child(attack_timer)

func _process(delta):
	if health >= 2 and GlobalProperties.is_reverse:
		$AnimatedSprite.play(color + "_idle")
		return
		
	if $AnimatedSprite.animation == color + "_awake":
		return
		
	elif health <= 0 and !GlobalProperties.is_reverse:
		$AnimatedSprite.play(color + "_dead")
		return
		
	var player_position = player.position
	var target_position = (player.position - position).normalized()
	if triggered or position.distance_to(player.position) < 50:
		move_and_slide(target_position * move_speed)
		if triggered == false:
			if GlobalProperties.is_reverse:
				$AnimatedSprite.play(color + "_awake")
				triggered = true
				return
			else:
				$AnimatedSprite.play(color + "_walk")
				triggered = true
				return
				
	if $AnimatedSprite.animation == color +"_dead":
		return
		
	if player_position.x > position.x:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.ZERO)
	
	if position.distance_to(player.position) < 20 and readyToAttack:
		attack()

func attack_delay_resetted():
	readyToAttack = true

func attack():
	attack_timer.start()
	if GlobalProperties.is_reverse:
		GlobalProperties.player_health += 1
	else:
		GlobalProperties.player_health -= 1
	readyToAttack = false
	
func animation_finished():
	if $AnimatedSprite.animation == color + "_awake":
		if GlobalProperties.is_reverse:
			$AnimatedSprite.play(color + "_walk")
		else:
			$AnimatedSprite.play(color + "_dead")

func get_damage():
	if GlobalProperties.is_reverse:
		health += 1
	else:
		health -= 1
