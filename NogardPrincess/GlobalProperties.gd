extends Node

export var is_reverse = false
export var dialogMode = false
export var player_health = 1
export var player_max_health = 5
var dialogIndex = 0
export var dialogFairy1 = ["One shall not solely walk\non well-known paths.",
"Diversity is what you\nwant to be looking for.",
"You shall try again,\nAnn-Bee, and try to pass."]

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
