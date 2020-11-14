extends Node2D
tool

const Letter = preload("res://letters/letter.tscn")
const WIDTH = 500
const HEIGHT = 200

export var word: String setget _set_word
func _set_word(new_word):
	if word == new_word:
		return
	
	word = new_word
	
	for child in $Letters.get_children():
		$Letters.remove_child(child)
	
	var letters = word.length()
	for i in letters:
		var letter = Letter.instance()
		letter.letter = word[i]
		letter.position.x = rand_range(-WIDTH / 2.0, WIDTH / 2.0)
		letter.position.y = rand_range(-HEIGHT / 2.0, HEIGHT / 2.0)
		$Letters.add_child(letter)


func _ready():
	for child in $Letters.get_children():
		child.drop($DropArea)
