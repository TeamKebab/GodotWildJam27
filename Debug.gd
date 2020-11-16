extends MarginContainer


var letters: Array
var letter_labels: Array

onready var _work_area = get_parent().find_node("WorkArea")
func _ready():
	for child in _work_area.find_node("Letters").get_children():
		if child is Letter:
			letters.append(child)
			var label = Label.new()
			letter_labels.append(label)
			$Container.add_child(label)
		
					
func _process(delta):
	find_node("WorkArea").text = "Free letters: " + String(_work_area.get_free_letters().size())
	
	for i in letters.size():
		var label = letter_labels[i]
		var letter = letters[i]
		
		label.text = letter.letter + ": " + letter.draggable.current_area.id 
