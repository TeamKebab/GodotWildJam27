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


var disabled: bool setget _set_disabled
func _set_disabled(new_disabled):
	if disabled == new_disabled:
		return
	
	disabled = new_disabled
	$CollisionShape2D.disabled = disabled
	
	
var hovering: bool
var dragging: bool
var current_area: DropArea
var drop_position: Vector2

var closest_drop_area: DropArea


func _ready():
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	
	
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
	

func pick():
	dragging = true
	drop_position = owner.global_position
	
	current_area.pick(self)
	
	emit_signal("picked")

	
func _on_mouse_entered():
	hovering = true


func _on_mouse_exited():
	hovering = false


func _unhandled_input(event):	
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if hovering and event.is_pressed():
			get_tree().set_input_as_handled()
			pick()
		elif not event.pressed and dragging:
			var drop_areas = get_overlapping_areas()
			
			if drop_areas.empty():
				drop(null)
			else:
				var drop_area = _find_closest(drop_areas)
				drop(drop_area)
	

func _find_closest(drop_areas):
	var min_distance = 1000000
	var closest: DropArea
	
	if drop_areas.size() == 1: 
		return drop_areas[0]
	
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
		
		var drop_areas = get_overlapping_areas()
		
		if drop_areas.empty():
			if closest_drop_area != null:
				closest_drop_area.is_hovering = false
				closest_drop_area = null
		else:
			var closest = _find_closest(drop_areas)
			
			if closest != closest_drop_area:
				if closest_drop_area != null:
					closest_drop_area.is_hovering = false
				closest_drop_area = closest
				closest_drop_area.is_hovering = true
	else:
		if closest_drop_area !=  null:
			closest_drop_area.is_hovering = false
			closest_drop_area = null
			
		owner.global_position = lerp(owner.global_position, drop_position, DROP_SPEED * delta)
