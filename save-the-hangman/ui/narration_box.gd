extends MarginContainer


export(Array, String) var lines: Array

var can_advance = false
var current_line = 0

onready var text_label = find_node("TextLabel")
onready var next_line = find_node("NextLine")

func _ready():
	text_label.text = lines[0]	
	
	yield(get_tree().create_timer(1), "timeout")
	can_advance = true
	next_line.show()


func _input(event):
	if can_advance:
		if event is InputEventKey or event is InputEventMouseButton:
			next_line()
			

func next_line():
	current_line += 1
	
	if current_line >= lines.size():
		return	
	
	text_label.text = lines[current_line]
	can_advance = false
	next_line.hide()
		
	if current_line == lines.size() - 1:
		find_parent("Level").start()
	else:	
		yield(get_tree().create_timer(1), "timeout")
		can_advance = true
		next_line.show()
					
	
