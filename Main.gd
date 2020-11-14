tool
extends Node2D

export var word: String setget _set_word
func _set_word(new_word):
	word = new_word
	
	if $WordTarget != null and $WorkArea != null:
		$WordTarget.word = word
		$WorkArea.word = word
