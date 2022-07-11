extends Area2D



func _on_Area2D_body_entered(_body:Node):
	Global.goto_scene("res://Scenes/GameWorld2.tscn")
