class_name Shuriken
extends Area2D

export var moveDirection : Vector2 = Vector2.DOWN
export var speed : int = 200
export var damage : int = 1

func _physics_process(delta):
	position += moveDirection * speed * delta


func _on_Shuriken_body_entered(body:Node):
	match body.name:

		# collision layer from the imported LDtk map
		"CollisionsLayer":
			queue_free()

		# staticbodies outside the edge of the screen
		"Frame":
			queue_free()

		# hostile creature
		"Mob":
			print("mob hit")
			body.hitPoints -= damage
			queue_free()
