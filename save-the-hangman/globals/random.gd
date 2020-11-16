extends Node


var rng = RandomNumberGenerator.new()


func _init():
	rng.randomize()	


func choose(list: Array):
	if list.empty():
		return null
	
	var index = randi() % list.size()
	return list[index]


func position(bounds: Rect2) -> Vector2:
	var x = rng.randi_range(bounds.position.x, bounds.end.x)
	var y = rng.randi_range(bounds.position.y, bounds.end.y)
	
	return Vector2(x,y)


func randf_range(from: float, to: float):
	return rng.randf_range(from, to)


func direction() -> Vector2:
	var angle = rng.randf_range(0, 2 * PI)
	return Vector2.RIGHT.rotated(angle)
