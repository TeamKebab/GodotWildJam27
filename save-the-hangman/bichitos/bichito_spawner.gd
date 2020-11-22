extends Node2D
class_name BichitoSpawner

export(PackedScene) var bichito_scene
export var max_bichitos:int = 3

onready var _screen_size = Vector2(1024,600)

onready var _container = $Bichitos
onready var _timer = $Timer


func _ready():
	_timer.connect("timeout", self, "_on_timer_timeout")
	

func start():
	_timer.start()
	
		
func destroy():
	_timer.disconnect("timeout", self, "_on_timer_timeout")
	for bichito in _container.get_children():
		if bichito.has_method("die"):
			bichito.die()


func _spawn():
	var bichito = bichito_scene.instance()
	bichito.global_position = _screen_size.abs() * Random.direction()
	
	_container.add_child(bichito)
	bichito.connect("died", self, "_on_bichito_died")
	

func _on_bichito_died(_bichito):
	if _timer.is_stopped():
		_timer.start()
	
	
func _on_timer_timeout():
	if _container.get_child_count() < max_bichitos:
		_spawn()
		_timer.start()
