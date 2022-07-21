extends GridContainer


# size of the map grid in cells
const COLUMNS = 15
const ROWS = 10


# the cell size is baked into the cell PackedScenes but is set here too
const CELL_SIZE = 16
const OFFSET = 8


var BlankCell : PackedScene = preload("res://Scenes/trBlank.tscn")
var PlayerCell : PackedScene = preload("res://Scenes/trPlayer.tscn")

var playerLocation : int = 0

var mobsList : Dictionary = {}


func _ready():
	refreshGrid()


func _input(event):
	if event is InputEventKey && event.is_pressed() && not event.echo:
		match event.scancode:
			KEY_RIGHT:
				print (testCollision(playerLocation, playerLocation + 1))
				playerLocation += 1
			KEY_LEFT:
				playerLocation -= 1
			KEY_UP:
				playerLocation -= COLUMNS
			KEY_DOWN:
				playerLocation += COLUMNS
		deleteChildren(self)
		refreshGrid()



func deleteChildren(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()



func refreshGrid() -> void:

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

	fromCoords.x = fromCoords.x * CELL_SIZE + OFFSET
	fromCoords.y = fromCoords.y * CELL_SIZE + OFFSET
	toCoords.x = toCoords.x * CELL_SIZE + OFFSET
	toCoords.y = toCoords.y * CELL_SIZE + OFFSET

	var spaceState = get_world_2d().direct_space_state
	var result = spaceState.intersect_ray(fromCoords, toCoords)

	if result:
		print("hit at point: ", result.position)
		return true
	else:
		return false




# convert cell index (int) to xy coords (Vector2)
func iToV(_i : int) -> Vector2:
	var _y = int(float(_i) / COLUMNS)
	var _x = int(_i % COLUMNS)
	print(str(_i) + " " + str(_x) + " " + str(_y))
	return Vector2(_x, _y)


# convert x/y cell coords to cell index (int)
func vToI(_v : Vector2) -> int:
	return int(_v.y * ROWS + _v.x)
