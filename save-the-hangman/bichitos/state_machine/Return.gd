extends "res://components/state_machine/state.gd"

export var speed: int = 50

var destination: Vector2


onready var _state_machine = get_parent()
onready var _bichito = _state_machine.get_parent()
onready var _animation = _bichito.find_node("AnimationPlayer")

onready var _work_area = find_parent("Level").find_node("WorkArea")

func enter():
	destination = _work_area.random_position()
	_animation.play("Default")	

func exit():
	_bichito.target.drop(null)
	
	
func update(delta):
	_bichito.global_position = _bichito.global_position.move_toward(destination, speed * delta)	
	_bichito.target.global_position = _bichito.global_position
	
	if _bichito.global_position == destination:	
		_bichito.target.drop(_work_area.drop_area)
		_state_machine._change_state("Wait")
