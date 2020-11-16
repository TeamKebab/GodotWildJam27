tool
extends Node2D

export var word: String setget _set_word
func _set_word(new_word):
	word = new_word
	
	if find_node("WordTarget") != null and find_node("WorkArea") != null:
		$WordTarget.word = word
		$WorkArea.word = word
