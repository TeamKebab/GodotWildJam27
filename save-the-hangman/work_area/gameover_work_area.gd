extends "res://work_area/work_area.gd"

const Bichito = preload("res://bichitos/tamed_bichito.tscn")

var out_of_bounds_margin = 50

var bichitos = []

onready var screen_size = Vector2(1024,600)
onready var positions = [
	Vector2(0, -out_of_bounds_margin),
	Vector2(screen_size.x / 3, -out_of_bounds_margin),
	Vector2(screen_size.x * 2 / 3, -out_of_bounds_margin),
	Vector2(screen_size.x, -out_of_bounds_margin),
	Vector2(0, screen_size.y + out_of_bounds_margin),
	Vector2(screen_size.x / 3, screen_size.y + out_of_bounds_margin),
	Vector2(screen_size.x * 2 / 3, screen_size.y + out_of_bounds_margin),
	Vector2(screen_size.x, screen_size.y + out_of_bounds_margin),
	Vector2(-out_of_bounds_margin, 0),
	Vector2(-out_of_bounds_margin, screen_size.y / 3),
	Vector2(-out_of_bounds_margin, screen_size.y * 2 / 3),
	Vector2(-out_of_bounds_margin, screen_size.y),
	Vector2(screen_size.x + out_of_bounds_margin, 0),
	Vector2(screen_size.x + out_of_bounds_margin, screen_size.y / 3),
	Vector2(screen_size.x + out_of_bounds_margin, screen_size.y * 2 / 3),
	Vector2(screen_size.x + out_of_bounds_margin, screen_size.y),
]

onready var word_target = find_parent("Level").find_node("WordTarget")
onready var targets = word_target.get_children()

func create_letter(i):
	var letter = .create_letter(i)
	var bichito = Bichito.instance()
	bichito.position = positions[bichitos.size() % positions.size()] - screen_size / 2
	bichitos.append(bichito)
	add_child(bichito)
	bichito.target = letter		
	
	for target in targets:
		if target.target_letter != letter.letter:
			continue
		
		bichito.letter_target = target
		break
	
	targets.erase(bichito.letter_target)
		
