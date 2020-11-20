extends "res://components/state_machine/state.gd"

export var time: float = 1
export var speed: int = 50

var destination: Vector2

onready var _screen_size = get_viewport().size

onready var _state_machine = get_parent()
onready var _bichito = _state_machine.get_parent()
onready var _animation = _bichito.find_node("AnimationPlayer")

# Initialize the state. E.g. change the animation.
func enter():
	_animation.play("Default")	
	_change_direction()
	
	yield(get_tree().create_timer(time), "timeout")
	_state_machine._change_state("Idle")
	

# Clean up the state. Reinitialize values like a timer.
func exit():
	pass


func handle_input(_event):
	pass


func update(delta):
	_bichito.position = _bichito.position.move_toward(destination, speed * delta)

	if _bichito.position == destination:
		_change_direction()
		
func _change_direction():
	destination = Random.position(Rect2(-_screen_size/2, _screen_size))
