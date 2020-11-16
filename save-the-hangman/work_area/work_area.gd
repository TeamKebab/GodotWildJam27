extends Node2D
tool

const Letter = preload("res://letters/letter.tscn")
const WIDTH = 500
const HEIGHT = 200

export var word: String setget _set_word
func _set_word(new_word):	
	word = new_word
	
	for child in $Letters.get_children():
		$Letters.remove_child(child)
	
	var letters = word.length()
	for i in letters:
		var letter = Letter.instance()
		letter.letter = word[i]
		letter.position = Random.position(Rect2(-WIDTH/2, -HEIGHT/2, WIDTH, HEIGHT))
		$Letters.add_child(letter)


onready var drop_area: DropArea = $DropArea

func _ready():
	for child in $Letters.get_children():
		child.drop(drop_area)

	
func get_free_letters():
	var letters: Array
	for item in drop_area.items:
		letters.append(item.owner)
		
	return letters
