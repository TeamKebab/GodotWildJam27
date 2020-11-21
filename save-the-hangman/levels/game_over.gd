extends Node

var can_advance = false


onready var narration_box = $NarrationBox
onready var animation = $AnimationPlayer
onready var booky = $Booky
onready var work_area = $WorkArea
onready var word_target = $WordTarget
onready var time_container = find_node("TimeContainer")
onready var time_label = time_container.find_node("Time")

onready var press_any_key = find_node("PressAnyKey")

func _ready():
	narration_box.connect("finished", self, "_on_narration_finished")
	word_target.connect("completed_word", self, "_on_completed_word")
	
	var minutes = Counter.time / 60
	var seconds = Counter.time - minutes * 60
	time_label.text = str(minutes) + ":" + str(seconds).pad_zeros(2)
	
	Music.play_from_start(load("res://levels/overworld_3.ogg"))

func _on_narration_finished():
	yield(get_tree().create_timer(1), "timeout")
	animation.play("NarrationFadeOut")
	yield(animation, "animation_finished")
	booky.start()
	work_area.start()

func _on_completed_word():
	time_container.show()
	yield(get_tree().create_timer(1), "timeout")
	press_any_key.show()
	can_advance = true
	
	
func _input(event):
	if can_advance:
		if event is InputEventKey or event is InputEventMouseButton:
			SceneLoader.start()	
