extends "res://bichitos/bichito.gd"



func get_available_letters() -> Array:
	return _work_area.get_free_letters() + _work_area.get_rotation_locked_letters()


func pick():
	target.pick(self)
	_state_machine._change_state("Running")
