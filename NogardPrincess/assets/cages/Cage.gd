extends AnimatedSprite

onready var player = get_parent().get_node("Player")
var triggered = false
func _ready():
	if GlobalProperties.is_reverse:
		play("unlocked")
	else:
		play("locked")
	connect("animation_finished", self, "animation_finished")

func _process(delta):
	if animation == "opening":
		return
		
	if position.distance_to(player.position) < 25 and !triggered:
		if GlobalProperties.is_reverse:
			play("closing")
		else:
			play("opening")
		GlobalProperties.next_skin()
		triggered = true

func animation_finished():
	if animation == "opening":
		if GlobalProperties.is_reverse:
			play("locked")
		else:
			play("unlocked")
