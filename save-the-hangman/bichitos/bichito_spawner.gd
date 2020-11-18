extends Node2D


const Bichito = preload("res://bichitos/bichito_primero.tscn")
const BichitoRotador = preload("res://bichitos/bichito_cabron_rotador.tscn")

export var max_bichito_primero:int = 3
export var max_bichito_rotador:int = 2

onready var _screen_size = get_viewport().size

onready var _primeros_container = $BichitosPrimeros
onready var _rotador_container = $BichitosRotadores
onready var _timer = $Timer

onready var _config = {
	"primero": {
		"max": max_bichito_primero,
		"container": _primeros_container,
		"scene": Bichito
	},
	"rotador": {
		"max": max_bichito_rotador,
		"container": _rotador_container,
		"scene": BichitoRotador
	}
}

func _ready():
	_timer.connect("timeout", self, "_on_timer_timeout")
	
	
func _spawn(config):
	var bichito = config.scene.instance()
	bichito.global_position = _screen_size.abs() * Random.direction()
	
	config.container.add_child(bichito)
	bichito.connect("died", self, "_on_bichito_died")
	

func _on_bichito_died(_bichito):
	if _timer.is_stopped():
		_timer.start()
	
	
func _on_timer_timeout():
	for key in _config:
		var config = _config[key]
		if config.container.get_child_count() < config.max:
			_spawn(config)
			_timer.start()
