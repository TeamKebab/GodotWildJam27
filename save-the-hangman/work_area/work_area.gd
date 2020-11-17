extends Node2D
tool

const Letter = preload("res://letters/letter.tscn")
const WIDTH = 500
const HEIGHT = 200

export var rotation_enabled: bool

	

export var word: String setget _set_word
func _set_word(new_word):	
	word = new_word
	
	for child in $Letters.get_children():
		$Letters.remove_child(child)
	
	var letters = word.length()
	for i in letters:
		var letter = Letter.instance()
		letter.letter = word[i]
		letter.position = Random.position(Rect2(-WIDTH/2.0, -HEIGHT/2.0, WIDTH, HEIGHT))
		$Letters.add_child(letter)

onready var drop_area: DropArea = $DropArea

func _ready():
	for letter in $Letters.get_children():
		letter.drop(drop_area)
		init_rotation(letter)


func _input(event):
	if rotation_enabled and event is InputEventKey and event.pressed:
		var event_letter = char(event.unicode).to_upper()
		turn_letters(event_letter)


func init_rotation(letter):
	if rotation_enabled:
		for _i in range(Random.randi(4)):
			letter.turn()
	else:
		letter.rotation = 0


func turn_letters(event_letter):
	for child in $Letters.get_children():
		if child.letter == event_letter:
			child.turn()


func get_free_letters():
	var letters = []
	for item in drop_area.items:
		letters.append(item.owner)
		
	return letters
