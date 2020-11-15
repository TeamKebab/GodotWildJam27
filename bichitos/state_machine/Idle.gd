extends "res://components/state_machine/state.gd"

var destination: Vector2

onready var _screen_size = get_viewport().size

onready var _state_machine = get_parent()
onready var _bichito = _state_machine.get_parent()
onready var _animation = _bichito.find_node("AnimationPlayer")

onready var _work_area = find_parent("Level").find_node("WorkArea")

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
		
	var free_letters: Array = _work_area.get_free_letters()
	if not free_letters.empty():
		_bichito.target = Random.choose(free_letters)
		_state_machine._change_state("Pursuing")
		
func _change_direction():
	destination = Random.position(Rect2(Vector2.ZERO, _screen_size))
