extends Area2D

onready var tween = get_node("Tween")



func _on_PickupGem_body_entered(body:Node):
	if body.name == "Player":
		tween.interpolate_property(self, "position", self.position, body.position,
			1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()