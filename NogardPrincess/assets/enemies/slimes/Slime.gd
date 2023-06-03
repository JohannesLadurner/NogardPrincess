extends KinematicBody2D

onready var player = get_parent().get_node("Player")
var move_speed = 50
export var gravity := 3000
var velocity := Vector2.ZERO
var player_position
export var triggered = false
var health := 1

var attack_timer = Timer.new()
var attack_delay = 100
var readyToAttack = true

func _ready():
	$AnimatedSprite.play("pink_dead")
	$AnimatedSprite.connect("animation_finished", self, "animation_finished")
	attack_timer.connect("timeout",self,"attack_delay_resetted")
	attack_timer.wait_time = 3
	attack_timer.one_shot = true
	add_child(attack_timer)

func _process(delta):
	if health >= 2:
		$AnimatedSprite.play("idle")
		return
		
	if $AnimatedSprite.animation == "pink_awake":
		return
		
	player_position = player.position
	var target_position = (player.position - position).normalized()
	if triggered or position.distance_to(player.position) < 50:
		move_and_slide(target_position * move_speed)
		if triggered == false:
			$AnimatedSprite.play("pink_awake")
			triggered = true
			return
	
	if $AnimatedSprite.animation == "pink_dead":
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
	print("here")

func attack():
	attack_timer.start()
	player.health += 1
	readyToAttack = false
	
func animation_finished():
	if $AnimatedSprite.animation == "pink_awake":
		$AnimatedSprite.play("pink_walk")

func get_damage():
	health += 1
