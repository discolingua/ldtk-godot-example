extends GridContainer


# size of the map grid in cells
const COLUMNS = 15
const ROWS = 10


# the cell size is baked into the cell PackedScenes but is set here too
const CELL_SIZE = 16
const OFFSET = 8

# Cell "buttons" for the map grid
var BlankCell : PackedScene = preload("res://Scenes/trBlank.tscn")
var PlayerCell : PackedScene = preload("res://Scenes/trPlayer.tscn")

var playerLocation : int = 0

var mobsList : Dictionary = {}


# character sheet display fields
onready var charPanel = $"../CharPanel"
onready var nameLabel = $"../CharPanel/NameLabel"
onready var strengthLabel = $"../CharPanel/StrengthLabel"
onready var reflexLabel = $"../CharPanel/ReflexLabel"
onready var bodyLabel = $"../CharPanel/BodyLabel"
onready var mainWeapLabel : Label = $"../CharPanel/MainWeapLabel"

func _ready():
	charPanel.visible = false

	var _q : String = "SELECT ID, NAME, DESC, SR, MR, LR, SPEED FROM weapons"
	var weaponTable : Array = Global.readFromdB(_q)
	Global.playerStats["MainWeapID"] = weaponTable[0]["ID"]
	Global.playerStats["MainWeapName"] = weaponTable[0]["NAME"]
	print( Global.playerStats["MainWeapName"] )
	nameLabel.text = "fdfsdf"
	refreshGrid()


func _input(event):

	# read key inputs, disable key repeat with event.echo
	if event is InputEventKey && event.is_pressed() && not event.echo:
		match event.scancode:
			KEY_RIGHT:
				if not testCollision(playerLocation, playerLocation + 1):
					playerLocation += 1
			KEY_LEFT:
				if not testCollision(playerLocation, playerLocation - 1):
					playerLocation -= 1
			KEY_UP:
				if not testCollision(playerLocation, playerLocation - COLUMNS):
					playerLocation -= COLUMNS
			KEY_DOWN:
				if not testCollision(playerLocation, playerLocation + COLUMNS):
					playerLocation += COLUMNS
			KEY_SPACE:
				if not charPanel.visible:
					charPanelUpdate()
					charPanel.visible = true
				else:
					charPanel.visible = false
		deleteChildren(self)
		refreshGrid()


func charPanelUpdate():
	nameLabel.text = "amazz"
	strengthLabel.text = str(Global.playerStats["Strength"])
	reflexLabel.text = str(Global.playerStats["Reflex"])
	bodyLabel.text = str(Global.playerStats["Body"])
	mainWeapLabel.text = str(Global.playerStats["MainWeapName"])


func deleteChildren(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()



func refreshGrid() -> void:

	# temp var
	var _cell

	for _i in ROWS * COLUMNS:
		if _i == playerLocation:
			_cell = PlayerCell.instance()
		else:
			_cell = BlankCell.instance()
		add_child(_cell)


func testCollision(fromCell: int, toCell : int) -> bool:

	var fromCoords : Vector2 = iToV(fromCell)
	var toCoords : Vector2 = iToV(toCell)

	# convert grid cell coordinates to screen space coordinates
	fromCoords.x = fromCoords.x * CELL_SIZE + OFFSET
	fromCoords.y = fromCoords.y * CELL_SIZE + OFFSET
	toCoords.x = toCoords.x * CELL_SIZE + OFFSET
	toCoords.y = toCoords.y * CELL_SIZE + OFFSET

	var spaceState = get_world_2d().direct_space_state
	var result = spaceState.intersect_ray(fromCoords, toCoords)

	if result:
		return true
	else:
		return false




# convert cell index (int) to xy coords (Vector2)
func iToV(_i : int) -> Vector2:
	var _y = int(float(_i) / COLUMNS)
	var _x = int(_i % COLUMNS)
	return Vector2(_x, _y)


# convert x/y cell coords to cell index (int)
func vToI(_v : Vector2) -> int:
	return int(_v.y * COLUMNS + _v.x)
