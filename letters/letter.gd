tool
extends KinematicBody2D
class_name Letter

const LETTERS = {
	'A': 0,
	'B': 1,
	'C': 2
}

const LETTER_HEIGHT = 32
const LETTER_WIDTH = 32


signal picked(bichito)
signal dropped


export var letter:String = 'A' setget _set_letter 
func _set_letter(new_letter):
	if new_letter < 'A' or new_letter > 'C':
		print("invalid letter " + new_letter)
		return
		
	letter = new_letter

	$Sprite.region_rect = Rect2(LETTER_WIDTH * LETTERS[letter], 0, LETTER_WIDTH, LETTER_HEIGHT)

var hovering = false setget _set_hovering
func _set_hovering(new_hovering):
	if hovering == new_hovering:
		return
		
	hovering = new_hovering
	
	if hovering:
		animation.play("Hover")
	else:
		animation.play_backwards("Hover")
	
onready var draggable = $Draggable
onready var animation = $AnimationPlayer

func _ready():
	draggable.connect("picked", self, "_on_picked")
	draggable.connect("dropped", self, "_on_dropped")
	draggable.connect("mouse_entered", self, "_on_mouse_entered")
	draggable.connect("mouse_exited", self, "_on_mouse_exited")


func pick(bichito):
	draggable.current_area.pick(draggable)
	emit_signal("picked", bichito)
	
func drop(area:DropArea):
	draggable.drop(area)
	

func _on_mouse_entered():
	_set_hovering(true)
	
	
func _on_mouse_exited():
	if not draggable.dragging:
		_set_hovering(false)
	
	
func _on_picked():	
	z_index = 100
	emit_signal("picked", null)
	
	
func _on_dropped(_area):	
	var parent = get_parent()
	parent.remove_child(self)
	parent.add_child(self)
	z_index = 0
	
	emit_signal("dropped")
