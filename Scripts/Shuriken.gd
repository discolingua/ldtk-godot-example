class_name Shuriken
extends Area2D

export var moveDirection : Vector2 = Vector2.DOWN
export var speed : int = 200

func _physics_process(delta):
	position += moveDirection * speed * delta
