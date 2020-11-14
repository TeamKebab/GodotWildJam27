tool

extends Area2D
class_name Draggable


signal picked
signal dropped


const DRAG_SPEED = 20

export(Shape2D) var shape: Shape2D setget _set_shape
func _set_shape(new_shape):
	shape = new_shape
	$CollisionShape2D.set_shape(shape)

var dragging: bool


func _ready():
	connect("input_event", self, "_on_input_event")


func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		dragging = true
		emit_signal("picked")


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			if dragging:
				dragging = false
				emit_signal("dropped")


func _physics_process(delta):
	if dragging:
		owner.global_position = lerp(owner.global_position, get_global_mouse_position(), DRAG_SPEED * delta)
		
