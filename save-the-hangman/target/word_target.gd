tool

extends Node2D

const Target = preload("res://target/target.tscn")

const LETTER_WIDTH = 48
const LETTER_SPACE = 6

signal completed_word

export var word: String setget _set_word
func _set_word(new_word):
	if new_word == word:
		return
		
	for child in get_children():
		remove_child(child)
	
	word = new_word
	
	var num_letters = word.length()
	
	for i in num_letters:
		if word[i] == " ":
			continue
			
		var target = Target.instance()
		target.target_letter = word[i]
		target.position.x = (i - (num_letters - 1.0) / 2) * (LETTER_WIDTH + LETTER_SPACE)
		add_child(target)
		target.connect("correct_letter", self, "_on_letter_placed")

	
func get_letters() -> Array:
	var letters = []		
	for child in get_children():
		var letter = child.get_current_letter()
		if letter != null:
			letters.append(letter)
	
	return letters
	

func _on_letter_placed():
	for child in get_children():
		if not child.is_correct_letter():
			return
		
	print("correct word!")
	emit_signal("completed_word")	
