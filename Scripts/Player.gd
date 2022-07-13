class_name Player
extends KinematicBody2D

enum DIRS {LEFT, RIGHT, UP, DOWN}
enum STATES {IDLE, MOVING}

const MAX_SPEED = 100
const FRICTION = 800

var state : int = STATES.IDLE
var facing : int = DIRS.DOWN
var velocity : Vector2 = Vector2.ZERO

var Shuriken : PackedScene = preload("res://Scenes/Shuriken.tscn")


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


	# set facing for 4-way shot
	if _i.y < 0 && facing != DIRS.UP:
		facing = DIRS.UP
	if _i.y > 0 && facing != DIRS.DOWN:
		facing = DIRS.DOWN
	if _i.x < 0 && facing != DIRS.LEFT:
		facing = DIRS.LEFT
	if _i.x > 0 && facing != DIRS.RIGHT:
		facing = DIRS.RIGHT

	if Input.is_action_just_pressed("ui_accept"):
		shoot(facing)

	return _i.normalized()

func shoot(_facing: int) -> void:
	var shuriken : Area2D = Shuriken.instance()
	shuriken.position = self.position
	match facing:
		DIRS.UP:
			shuriken.moveDirection = Vector2.UP
		DIRS.DOWN:
			shuriken.moveDirection = Vector2.DOWN
		DIRS.LEFT:
			shuriken.moveDirection = Vector2.LEFT
		DIRS.RIGHT:
			shuriken.moveDirection = Vector2.RIGHT

	get_parent().add_child(shuriken)
