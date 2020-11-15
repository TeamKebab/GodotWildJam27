extends "res://components/state_machine/state.gd"

export var speed: int = 50

var destination: Vector2

onready var _screen_size = get_viewport().size

onready var _state_machine = get_parent()
onready var _bichito = _state_machine.get_parent()
onready var _animation = _bichito.find_node("AnimationPlayer")

# Initialize the state. E.g. change the animation.
func enter():
	_animation.play("Default")	
	destination = _bichito.target.global_position

# Clean up the state. Reinitialize values like a timer.
func exit():
	pass


func handle_input(_event):
	pass


func update(delta):
	if _bichito.target == null:
		_state_machine._change_state("Idle")
	
	_bichito.global_position = _bichito.global_position.move_toward(destination, speed * delta)

	if _bichito.global_position == destination:
		_state_machine._change_state("Running")
		
	
