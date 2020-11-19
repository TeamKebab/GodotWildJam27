extends Node2D


export(PackedScene) var bichito_scene
export var max_bichitos:int = 3

onready var _screen_size = get_viewport().size

onready var _container = $Bichitos
onready var _timer = $Timer


func _ready():
	_timer.connect("timeout", self, "_on_timer_timeout")
	
	
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
