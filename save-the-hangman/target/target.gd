extends "res://components/one_letter_space.gd"
class_name Target


signal correct_letter

export var target_letter = 'A'

onready var drop_area = $DropArea

func _ready():
	drop_area.connect("item_picked", self, "_on_item_picked")
	drop_area.connect("item_dropped", self, "_on_item_dropped")


func is_correct_letter():
	return current_letter != null and current_letter.is_correct_letter(target_letter)


func _on_letter_rotated():
	if is_correct_letter():
		emit_signal("correct_letter")


func _on_item_picked(letter):
	letter.owner.disconnect("rotated", self, "_on_letter_rotated")


func _on_item_dropped(letter):	
	letter.owner.connect("rotated", self, "_on_letter_rotated")
	
	if is_correct_letter():
		emit_signal("correct_letter")
