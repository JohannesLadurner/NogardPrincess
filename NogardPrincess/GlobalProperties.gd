extends Node

export var is_reverse = false
export var dialogMode = false
export var player_health = 1
export var player_max_health = 5
export var endGame = false
export var dialogIndex = 0
export var dialogFairy1 = ["One shall not solely walk\non well-known paths.",
"Diversity is what you\nwant to be looking for.",
"You shall try again,\nAnn-Bee, and try to pass."]

export var dialogFairy2 = ["You did well!", 
"Now you shall go and\nfulfill your destiny.",
"Remember: Even the smallest\nfroggie can change the future!"]

export var player_skin = 0
var skins = ["stereo_strong_", "stereo_medium_", "rookie_", "medium_", "strong_"]

func get_dialog_text():
	if dialogIndex < dialogFairy1.size():
		return dialogFairy1[dialogIndex]
	if dialogIndex == dialogFairy1.size():
		return null
	if dialogIndex > dialogFairy1.size() and dialogIndex - dialogFairy1.size() - 1 < dialogFairy2.size():
		return dialogFairy2[dialogIndex-dialogFairy2.size()-1]
	return null

func continueDialog():
	dialogIndex += 1;

func get_skin():
	return skins[player_skin]

func next_skin():
	player_skin += 1
