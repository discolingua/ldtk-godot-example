extends KinematicBody2D

export var hitPoints : int = 3

var hasSpoken : bool = false

func _physics_process(_delta):
	if hitPoints < 1:
		queue_free()

func _on_Interact_Collider_body_entered(body:Node):
	match body.name:
		"Player":
			if !hasSpoken:
				print("player jibjab")
				hasSpoken = true