extends "res://components/state_machine/state.gd"

export var speed: int = 50

onready var _screen_size = get_viewport().size

onready var _state_machine = get_parent()
onready var _bichito = _state_machine.get_parent()
onready var _animation = _bichito.find_node("AnimationPlayer")

onready var _work_area = find_parent("Level").find_node("WorkArea")

# Initialize the state. E.g. change the animation.
func enter():
	_animation.play("Default")

# Clean up the state. Reinitialize values like a timer.
func exit():
	pass


func handle_input(_event):
	pass


func update(delta):
	_bichito.global_position = _bichito.global_position.move_toward(_bichito.target.global_position, speed * delta)

	if _bichito.global_position == _bichito.target.global_position:	
		_bichito.pick()
	
