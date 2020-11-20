extends Node


onready var level_complete = $LevelComplete
onready var word_target = $WordTarget
onready var work_area = $WorkArea

func _ready():
	word_target.connect("completed_word", self, "_on_completed_word")
	

func _on_completed_word():
	for child in get_children():
		if child is BichitoSpawner:
			child.destroy()
		
	level_complete.show_time()
	
