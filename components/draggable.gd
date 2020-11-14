tool

extends Area2D
class_name Draggable


signal picked
signal dropped(area)


const DRAG_SPEED = 20
const DROP_SPEED = 30


export(Shape2D) var shape: Shape2D setget _set_shape
func _set_shape(new_shape):
	shape = new_shape
	$CollisionShape2D.set_shape(shape)

var dragging: bool
var current_area: DropArea
var drop_position: Vector2


func _ready():
	connect("input_event", self, "_on_input_event")

func drop(area:DropArea):
	dragging = false
	
	if area != null:	
		current_area = area	
		
		if current_area.snap_to_center:
			drop_position = current_area.global_position
		else:
			drop_position = owner.global_position
	
	current_area.drop(self)	
	emit_signal("dropped", current_area) 
	
		
func _on_input_event(_viewport, _event, _shape_idx):
	if Engine.editor_hint:
		return
	
	if Input.is_action_just_pressed("mouse_left"):
		_picked()


func _input(event):
	if Engine.editor_hint:
		return
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			if dragging:
				_dropped()


func _picked():
	dragging = true
	drop_position = owner.global_position
	
	current_area.pick(self)
	
	emit_signal("picked")


func _dropped():
	var drop_areas = get_overlapping_areas()
	
	if drop_areas.empty():
		drop(null)
	else:
		var drop_area = _find_closest(drop_areas)
		drop(drop_area)
	


func _find_closest(drop_areas):
	var min_distance = 1000000
	var closest: DropArea
	
	for drop_area in drop_areas:
		var distance = owner.global_position.distance_squared_to(drop_area.global_position)
		if distance < min_distance:
			closest = drop_area
			min_distance = distance
	
	return closest

		
func _physics_process(delta):
	if Engine.editor_hint:
		return
	
	if dragging:
		owner.global_position = lerp(owner.global_position, get_global_mouse_position(), DRAG_SPEED * delta)
	else:
		owner.global_position = lerp(owner.global_position, drop_position, DROP_SPEED * delta)
