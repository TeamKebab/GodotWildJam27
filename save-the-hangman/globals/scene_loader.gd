extends Node


const LEVELS = [
	"res://levels/Level1.tscn",
	"res://levels/Level2.tscn",
	"res://levels/Level3.tscn",
	"res://levels/Level4.tscn",
	"res://levels/Level5.tscn",
]


var current_scene
var current_level = 0

func _ready():
	set_current_scene()
	
	
func set_current_scene():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)


func next_level():
	if current_level < LEVELS.size() - 1:
		current_level += 1
		load_level(LEVELS[current_level])
		
		
func load_level(path):
	call_deferred("_deferred_load_level", path)


func _deferred_load_level(path):
	current_scene.free()
		
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
		
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
