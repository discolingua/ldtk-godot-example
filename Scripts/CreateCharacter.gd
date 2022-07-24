extends Node2D


# This script handles the character creation process


# character sheet display fields
onready var charPanel = $CharPanel
onready var nameLabel = $CharPanel/NameLabel
onready var strengthLabel = $CharPanel/StrengthLabel
onready var reflexLabel = $CharPanel/ReflexLabel
onready var bodyLabel = $CharPanel/BodyLabel


onready var statPoints : int = 5
onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()





func _input(event):

	# read key inputs, disable key repeat with event.echo
	if event is InputEventKey && event.is_pressed() && not event.echo:
		match event.scancode:
			KEY_R:
				print(bumpStat())
				rollStats()
			KEY_SPACE:
				if not charPanel.visible:
					charPanel.visible = true
				else:
					charPanel.visible = false




func bumpStat() -> String:
	print("bump")
	var _i = rng.randi_range(0,2)
	match _i:
		0:
			return "Strength"
		1:
			return "Reflex"
	return "Body"





func freshenStats() -> void:
	strengthLabel.text = str(Global.playerStats["Strength"])
	reflexLabel.text = str(Global.playerStats["Reflex"])
	bodyLabel.text = str(Global.playerStats["Body"])
	pass



func rollStats():
	print ("rollstats")
	Global.playerStats["Strength"] = 0
	Global.playerStats["Reflex"] = 0
	Global.playerStats["Body"] = 0
	freshenStats()

	# while statPoints > 0:
	# 	var s : String = bumpStat()
	# 	if Global.playerStats[s] <= 3:
	# 		Global.playerStats[s] += 1
	# 		statPoints -= 1

