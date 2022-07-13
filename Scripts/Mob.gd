extends KinematicBody2D

export var hitPoints : int = 1


func _physics_process(_delta):
	if hitPoints < 1:
		queue_free()