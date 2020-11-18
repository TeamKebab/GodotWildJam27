extends "res://bichitos/bichito.gd"

onready var _word_target = find_parent("Level").find_node("WordTarget")

func get_available_letters() -> Array:
	var letters = _work_area.get_free_letters() + _word_target.get_letters()
	var correct_letters = []
	for letter in letters:
		if letter.rotation == 0:
			correct_letters.append(letter)
	
	return correct_letters


func pick():
	for _i in range(Random.randi(2) + 1):
		target.turn()
		
	_state_machine._change_state("Wait")


func _on_target_rotated():
	if target.rotation != 0:
		_state_machine._change_state("Idle")
