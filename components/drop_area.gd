tool

extends Area2D
class_name DropArea

signal item_picked(item)
signal item_dropped(item)


export(Shape2D) var shape: Shape2D setget _set_shape
func _set_shape(new_shape):
	shape = new_shape
	$CollisionShape2D.set_shape(shape)

export(bool) var snap_to_center: bool 


func pick(item):
	emit_signal("item_picked", item)
	

func drop(item):
	emit_signal("item_dropped", item)
	
