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
		if word[i] == " ":
			continue
		var letter = Letter.instance()
		letter.letter = word[i]
		letter.position = _random_position()
		$Letters.add_child(letter)


onready var container: Node2D = $Letters
onready var drop_area: DropArea = $DropArea
onready var rotation_block = $RotationBlock


func _ready():
	for letter in container.get_children():
		letter.drop(drop_area)
		init_rotation(letter)


func _input(event):
	if rotation_enabled and event is InputEventKey and event.pressed:
		var event_letter = char(event.unicode).to_upper()
		turn_letters(event_letter)

func random_position():
	return global_position + _random_position()
	
	
func _random_position():
	return Random.position(Rect2(-WIDTH/2.0, -HEIGHT/2.0, WIDTH, HEIGHT))
	

	
func init_rotation(letter):
	if rotation_enabled:
		for _i in range(Random.randi(4)):
			letter.turn()
	else:
		letter.rotation = 0


func turn_letters(event_letter):
	for child in container.get_children():
		if child.letter == event_letter and not rotation_block.has_letter(child):
			child.turn()


func get_rotation_locked_letters():
	var letters = []
	if rotation_block.current_letter != null:
		letters.append(rotation_block.current_letter)
		
	return letters


func get_free_letters():
	var letters = []
	for item in drop_area.items:
		letters.append(item.owner)
		
	return letters
