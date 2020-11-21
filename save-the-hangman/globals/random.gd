extends Node


var rng = RandomNumberGenerator.new()


func _init():
	rng.randomize()	


func choose(list: Array):
	if list.empty():
		return null
	
	var index = randi() % list.size()
	return list[index]


func shuffle_word(word: String):
	var list = []
	for i in word:
		list.append(i)
	
	if list.empty():
		return list
	
	var shuffled = []
	
	for _i in range(list.size()):
		var letter = choose(list)
		list.erase(letter)
		shuffled.append(letter)
	
	return shuffled
	
	
func position(bounds: Rect2) -> Vector2:
	var x = rng.randi_range(bounds.position.x, bounds.end.x)
	var y = rng.randi_range(bounds.position.y, bounds.end.y)
	
	return Vector2(x,y)


func direction() -> Vector2:
	var angle = rng.randf_range(0, 2 * PI)
	return Vector2.RIGHT.rotated(angle)


func randf_range(from: float, to: float) -> float:
	return rng.randf_range(from, to)


func randi(to: int) -> int:
	return rng.randi() % to
