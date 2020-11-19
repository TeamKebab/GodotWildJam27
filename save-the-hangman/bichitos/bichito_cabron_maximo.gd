extends "res://bichitos/bichito.gd"


onready var _word_target = find_parent("Level").find_node("WordTarget")


func get_available_letters() -> Array:
	return _word_target.get_letters()


func pick():
	target.pick(self)
	_state_machine._change_state("Return")
