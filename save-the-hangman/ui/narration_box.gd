extends MarginContainer

signal finished

export var talk_speed = 20
export(Array, String) var lines: Array

var time = 0
var can_advance = false
var current_line = 0

onready var text_label = find_node("TextLabel")
onready var next_line_icon = find_node("NextLine")
onready var booky = find_node("Booky")
onready var next_sound = $NextSound

func _ready():
	start_line()


func _input(event):
	if can_advance:
		if event is InputEventKey or event is InputEventMouseButton:
			next_sound.play()
			next_line()


func _process(delta):
	if current_line >= lines.size():
		return	
		
	var total_letters = lines[current_line].length()
	
	if text_label.visible_characters >= total_letters:
		return 
		
	time += delta
	
	text_label.visible_characters = min(total_letters, floor(time * talk_speed))
	
	if text_label.visible_characters >= total_letters:
		booky.stop_talking()
		
		if current_line < lines.size() - 1:
			next_line_icon.show()
			can_advance = true
		else:
			emit_signal("finished")
		

func start_line():
	text_label.text = lines[current_line]	
	text_label.visible_characters = 0
	can_advance = false
	time = 0
	next_line_icon.hide()
	booky.start_talking()			


func next_line():
		
	current_line += 1
	
	if current_line >= lines.size():
		return	
	
	start_line()
	
	if current_line == lines.size() - 1:
		find_parent("Level").start()

					
		
