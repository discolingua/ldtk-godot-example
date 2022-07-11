class_name Player
extends KinematicBody2D


enum STATES {IDLE, MOVING}

const MAX_SPEED = 100
const FRICTION = 800

var state : int = STATES.IDLE
var velocity : Vector2 = Vector2.ZERO


func _physics_process(delta) -> void:
	match state:
		STATES.IDLE: idle(delta)
		STATES.MOVING: moving(delta)


func moving(delta) -> void:
	var _i : Vector2 = readMovement()
	if _i != Vector2.ZERO:

		velocity += move_and_slide(_i * MAX_SPEED)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		state = STATES.IDLE


func idle(delta) -> void:
	var _i = readMovement()
	if _i != Vector2.ZERO:
		state = STATES.MOVING
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)


func readMovement() -> Vector2:
	var _i : Vector2 = Vector2.ZERO

	_i.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	_i.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	return _i.normalized()
