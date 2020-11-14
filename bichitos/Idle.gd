extends "res://components/state_machine/state.gd"

var destination: Vector2
var path: PoolVector2Array

onready var _screen_size = get_viewport().size

onready var _bichito = get_parent().get_parent()
onready var _animation = _bichito.find_node("AnimationPlayer")

# Initialize the state. E.g. change the animation.
func enter():
	_animation.play("Default")	
	_change_direction()

# Clean up the state. Reinitialize values like a timer.
func exit():
	pass


func handle_input(_event):
	pass


func update(delta):
	_bichito.position = _bichito.position.move_toward(destination, 50 * delta)

	if _bichito.position == destination:
		_change_direction()
		

func _change_direction():
	destination = Vector2(rand_range(-_screen_size.x/2, _screen_size.x/2), rand_range(-_screen_size.y/2, _screen_size.y/2))
