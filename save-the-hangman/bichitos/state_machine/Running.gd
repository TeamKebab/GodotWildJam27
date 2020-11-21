extends "res://components/state_machine/state.gd"

export var speed: int = 200
export var out_of_bounds_margin: int = -50
export var narration_box_size = 20
export var max_rotation_speed: float = 0.3

var motion = Vector2.ZERO

onready var _screen_size = get_viewport().size

onready var _state_machine = get_parent()
onready var _bichito = _state_machine.get_parent()
onready var _animation = _bichito.find_node("AnimationPlayer")

# Initialize the state. E.g. change the animation.
func enter():
	_animation.play("Default")	
	_go_to_center()

# Clean up the state. Reinitialize values like a timer.
func exit():
	_bichito.target.drop(null)


func handle_input(_event):
	pass


func update(delta):
	motion = motion.rotated(Random.randf_range(-max_rotation_speed, max_rotation_speed))
	
	_bichito.position = _bichito.position + motion * delta
	_bichito.target.global_position = _bichito.global_position
	
	if _bichito.global_position.x < -out_of_bounds_margin || \
		_bichito.global_position.x > _screen_size.x + out_of_bounds_margin || \
		_bichito.global_position.y < -out_of_bounds_margin + narration_box_size || \
		_bichito.global_position.y > _screen_size.y + out_of_bounds_margin:
			_go_to_center()


func _go_to_center():
	motion = _bichito.global_position.direction_to(_screen_size / 2) * speed	
