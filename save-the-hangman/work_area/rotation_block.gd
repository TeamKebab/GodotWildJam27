extends "res://components/one_letter_space.gd"
class_name RotationBlock

export var disabled:bool setget _set_disabled
func _set_disabled(new_disabled):
	disabled = new_disabled
	$DropArea.disabled = disabled
	
onready var drop_area = $DropArea
onready var drop_sound = $DropSound

func _ready():
	drop_area.connect("item_dropped", self, "_on_item_dropped")
	
	
func has_letter(letter):
	return current_letter == letter


func _on_item_dropped(_item):
	drop_sound.play()
