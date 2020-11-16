extends Node


var _drop_areas = 0

func new_drop_area() -> int:
	_drop_areas += 1
	return _drop_areas


var _bichitos = 0

func new_bichito() -> int:
	_bichitos += 1
	return _bichitos
