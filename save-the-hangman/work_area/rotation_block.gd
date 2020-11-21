extends "res://components/one_letter_space.gd"
class_name RotationBlock

export var disabled:bool setget _set_disabled
func _set_disabled(new_disabled):
	disabled = new_disabled
	$DropArea.disabled = disabled
	
	
func has_letter(letter):
	return current_letter == letter
