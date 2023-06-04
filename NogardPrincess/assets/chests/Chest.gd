extends AnimatedSprite

onready var player = get_parent().get_node("Player")

func _ready():
	play("closed")
	$AnimatedSprite.visible = false
	$AnimatedSprite.connect("animation_finished", self, "animation_finished")

func _process(delta):
	if position.distance_to(player.position) < 10:
		$AnimatedSprite.play("blink")
		GlobalProperties.next_skin()
		play("opened")

func animation_finished():
	$AnimatedSprite.visible = false
