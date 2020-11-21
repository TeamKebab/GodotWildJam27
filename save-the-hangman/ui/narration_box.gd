extends MarginContainer

export var talk_speed = 20
export(Array, String) var lines: Array

var time = 0
var can_advance = false
var current_line = 0

onready var text_label = find_node("TextLabel")
onready var next_line = find_node("NextLine")
onready var booky = find_node("Booky")

func _ready():
	start_line()


func _input(event):
	if can_advance:
		if event is InputEventKey or event is InputEventMouseButton:
			next_line()


func _process(delta):
	if current_line >= lines.size():
		return	
		
	var total_letters = lines[current_line].length()
	
	time += delta
	
	text_label.visible_characters = floor(time * talk_speed)
	
	if text_label.visible_characters >= total_letters:
		booky.stop_talking()
		
		if current_line < lines.size() - 1:
			next_line.show()
			can_advance = true
		

func start_line():
	text_label.text = lines[current_line]	
	text_label.visible_characters = 0
	can_advance = false
	time = 0
	next_line.hide()
	booky.start_talking()			


func next_line():
		
	current_line += 1
	
	if current_line >= lines.size():
		return	
	
	start_line()
	
	if current_line == lines.size() - 1:
		find_parent("Level").start()

					
		
