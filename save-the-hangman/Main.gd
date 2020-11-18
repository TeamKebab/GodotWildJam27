tool
extends Node2D

export var rotation_enabled: bool setget _set_rotation_enabled
func _set_rotation_enabled(value):
	rotation_enabled = value
	if $WorkArea != null:
		$WorkArea.rotation_enabled = rotation_enabled


export var word: String setget _set_word
func _set_word(new_word):
	word = new_word
	
	if $WordTarget != null and $WorkArea != null:
		$WordTarget.word = word
		$WorkArea.word = word
