extends Node

export var is_reverse = false
export var dialogMode = false
export var player_health = 1
export var player_max_health = 5
var dialogIndex = 0
export var dialogFairy1 = ["Hello, what are you doing??????",
"This is some test Text from\nfairy"]

func get_dialog_text():
	if dialogIndex < dialogFairy1.size():
		var text = dialogFairy1[dialogIndex]
		return text
	return null

func continueDialog():
	if dialogIndex < dialogFairy1.size():
		dialogIndex += 1;
		return true
	return false
