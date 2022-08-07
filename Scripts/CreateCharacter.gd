extends Node2D


# This script handles the character creation process


# how many stat points to distribute?
const INITIAL_STAT_POINTS = 3

# what's the highest a stat can be during chargen?
const CHARGEN_STAT_CEILING = 3


# character sheet display fields
onready var charPanel = $CharPanel
onready var nameLabel = $CharPanel/NameLabel
onready var strengthLabel = $CharPanel/StrengthLabel
onready var reflexLabel = $CharPanel/ReflexLabel
onready var bodyLabel = $CharPanel/BodyLabel
onready var mainWeapLabel = $CharPanel/MainWeapLabel


onready var statPoints : int = INITIAL_STAT_POINTS

onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	rollStats()


func _input(event):
	# read key inputs, disable key repeat with event.echo
	if event is InputEventKey && event.is_pressed() && not event.echo:
		match event.scancode:

			# reroll
			KEY_R:
				statPoints = INITIAL_STAT_POINTS
				rollStats()

			# toggle panel (might not make sense in final version)
			KEY_SPACE:
				if not charPanel.visible:
					charPanel.visible = true
				else:
					charPanel.visible = false

			# finished with chargen, this could use a y/n confirm
			KEY_ENTER:
				Global.goto_scene("res://Scenes/Gameworld.tscn")



# picks a stat to increase
func bumpStat() -> String:
	var _i = rng.randi_range(0,2)
	match _i:
		0:
			return "Strength"
		1:
			return "Reflex"
	return "Body"


# copies the stats from the global vars to the Label text field contents
func freshenStats() -> void:
	strengthLabel.text = "Strength: " + str(Global.playerStats["Strength"])
	reflexLabel.text = "Reflex: " + str(Global.playerStats["Reflex"])
	bodyLabel.text = "Body: " + str(Global.playerStats["Body"])
	mainWeapLabel.text = Global.playerStats["MainWeapName"]

func rollStats():
	Global.playerStats["Strength"] = 0
	Global.playerStats["Reflex"] = 0
	Global.playerStats["Body"] = 0

	Global.playerStats["mainWeapName"] = "default"

	while statPoints > 0:
		var s : String = bumpStat()

		if Global.playerStats[s] < CHARGEN_STAT_CEILING:
			Global.playerStats[s] += 1
			statPoints -= 1



	freshenStats()