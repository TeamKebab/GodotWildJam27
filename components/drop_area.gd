tool

extends Area2D
class_name DropArea

signal item_picked(item)
signal item_dropped(item)
signal is_hovering_changed(is_hovering)


export(Shape2D) var shape: Shape2D setget _set_shape
func _set_shape(new_shape):
	shape = new_shape
	$CollisionShape2D.set_shape(shape)

export(bool) var snap_to_center: bool 

var disabled: bool setget _set_disabled
func _set_disabled(new_disabled):
	if disabled == new_disabled:
		return
	
	disabled = new_disabled
	$CollisionShape2D.disabled = disabled


var is_hovering: bool setget _set_is_hovering
func _set_is_hovering(new_value):
	if is_hovering == new_value:
		return
	
	is_hovering = new_value
	emit_signal("is_hovering_changed", is_hovering)	
	
	
func pick(item):
	emit_signal("item_picked", item)
	

func drop(item):
	emit_signal("item_dropped", item)
	
