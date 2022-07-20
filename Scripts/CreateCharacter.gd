extends Control



# load initial field values from global dictionary
func _ready() -> void:
	freshenStats()


func freshenStats() -> void:
	$StatColumn/RowName/ValueName.text = Global.playerStats["Name"]
	$StatColumn/RowJob/ValueJob.text = Global.playerStats["Job"]
	$StatColumn/RowLevel/ValueLevel.text = str(Global.playerStats["Level"])

	$StatColumn/RowStrength/ValueStrength.text = str(Global.playerStats["Strength"])
	$StatColumn/RowReflex/ValueReflex.text = str(Global.playerStats["Reflex"])
	$StatColumn/RowBody/ValueBody.text = str(Global.playerStats["Body"])
