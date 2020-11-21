extends Node2D

const Letter = preload("res://letters/letter.tscn")
const WIDTH = 500
const HEIGHT = 200

export var rotation_enabled: bool
export var show_rotation_block: bool

export var word: String


onready var container: Node2D = $Letters
onready var drop_area: DropArea = $DropArea
onready var rotation_block = $RotationBlock


func _ready():
	if show_rotation_block:
		rotation_block.show()
		rotation_block.disabled = false
			
func _input(event):
	if rotation_enabled and event is InputEventKey and event.pressed:
		var event_letter = char(event.unicode).to_upper()
		turn_letters(event_letter)


func start():
	for child in $Letters.get_children():
		$Letters.remove_child(child)
	
	var letters = Random.shuffle_word(word)
	for i in letters:
		if i == " ":
			continue
		var letter = Letter.instance()
		letter.letter = i
		letter.position = _random_position()
		$Letters.add_child(letter)
		letter.drop(drop_area)
		init_rotation(letter)
		
		yield(get_tree().create_timer(0.5), "timeout")

		
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
