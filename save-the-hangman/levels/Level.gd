extends Node

export(AudioStreamOGGVorbis) var music

onready var level_complete = $LevelComplete
onready var word_target = $WordTarget
onready var work_area = $WorkArea
onready var complete_sound = $CompleteSound

func _ready():
	word_target.connect("completed_word", self, "_on_completed_word")
	Music.continue_playing(music)


func start():
	for child in get_children():
		if child.has_method("start"):
			child.start()
				

func _on_completed_word():
	complete_sound.play()
	
	for child in get_children():
		if child is BichitoSpawner:
			child.destroy()
		
	level_complete.show_time()
	
