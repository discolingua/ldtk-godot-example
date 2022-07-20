extends GridContainer

const COLUMNS = 15
const ROWS = 10

var BlankCell : PackedScene = preload("res://Scenes/trBlank.tscn")
var PlayerCell : PackedScene = preload("res://Scenes/trPlayer.tscn")

var playerLocation : int = 0

func _ready():
	refreshGrid()


func _input(event):
	if event is InputEventKey && event.is_pressed() && not event.echo:
		match event.scancode:
			KEY_RIGHT:
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


# convert cell index (int) to xy coords (Vector2)
func iToV(_i : int) -> Vector2:
	var _y = int(float(_i) / ROWS)
	var _x = int(_i % ROWS)
	return Vector2(_x, _y)


# convert x/y cell coords to cell index (int)
func vToI(_v : Vector2) -> int:
	return int(_v.y * COLUMNS + _v.x)
