extends "res://components/state_machine/state.gd"

export var speed: int = 50

onready var _screen_size = get_viewport().size

onready var _state_machine = get_parent()
onready var _bichito = _state_machine.get_parent()
onready var _animation = _bichito.find_node("AnimationPlayer")

# Initialize the state. E.g. change the animation.
func enter():
	_animation.play("Default")


func update(delta):
	_bichito.global_position = _bichito.global_position.move_toward(_bichito.letter_target.global_position, speed * delta)
	_bichito.target.global_position = _bichito.global_position
	
	if _bichito.global_position == _bichito.letter_target.global_position:	
		_bichito.drop()
	
	
