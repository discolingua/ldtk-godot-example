extends Node2D


# character sheet display fields
onready var charPanel = $CharPanel
onready var nameLabel = $CharPanel/NameLabel
onready var strengthLabel = $CharPanel/StrengthLabel
onready var reflexLabel = $CharPanel/ReflexLabel
onready var bodyLabel = $CharPanel/BodyLabel


onready var statPoints : int = 5



func _input(event):

	# read key inputs, disable key repeat with event.echo
	if event is InputEventKey && event.is_pressed() && not event.echo:
		match event.scancode:
			KEY_SPACE:
				if not charPanel.visible:
					charPanel.visible = true
				else:
					charPanel.visible = false




func bumpStat() -> String:
	var _i = rand_range(0,2)
	match _i:
		0:
			return "Strength"
		1:
			return "Reflex"
	return "Body"





func freshenStats() -> void:
	pass



func rollStats():
	Global.playerStats["Strength"] = 0
	Global.playerStats["Reflex"] = 0
	Global.playerStats["Body"] = 0

	while statPoints > 0:
		var s : String = bumpStat()
		if Global.playerStats[s] <= 3:
			Global.playerStats[s] += 1
			statPoints -= 1

