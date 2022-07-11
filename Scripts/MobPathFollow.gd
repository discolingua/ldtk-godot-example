extends PathFollow2D


export var moveSpeed = 20

func _process(delta):
	set_offset(get_offset() + moveSpeed * delta)

