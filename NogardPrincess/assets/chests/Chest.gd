extends AnimatedSprite

onready var player = get_parent().get_node("Player")
var triggered = false
func _ready():
	if GlobalProperties.is_reverse:
		play("opened")
	else:
		play("closed")
	$AnimatedSprite.visible = false
	$AnimatedSprite.connect("animation_finished", self, "animation_finished")

func _process(delta):
	if position.distance_to(player.position) < 10 and !triggered:
		$AnimatedSprite.visible = true
		$AnimatedSprite.play("blink")
		GlobalProperties.next_skin()
		$ChestSound.play()
		if GlobalProperties.is_reverse:
			play("closed")
		else:
			play("opened")
		triggered = true

func animation_finished():
	$AnimatedSprite.visible = false
