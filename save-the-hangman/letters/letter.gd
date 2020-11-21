tool
extends KinematicBody2D
class_name Letter

const LETTERS = {
	'A': 0,
	'B': 1,
	'C': 2,
	'D': 3,
	'E': 4,
	'G': 5,
	'H': 6,
	'I': 7,
	'K': 8,
	'L': 9,
	'N': 10,
	'O': 11,
	'P': 12,
	'R': 13,
	'S': 14,
	'T': 15,
	'U': 16,
}

const LETTER_HEIGHT = 48
const LETTER_WIDTH = 48


signal picked(bichito)
signal dropped
signal rotated

export var letter:String = 'A' setget _set_letter 
func _set_letter(new_letter):
	if not LETTERS.has(new_letter):
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
onready var drag_sound = $DragSound

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
	

func is_correct_letter(target_letter) -> bool:
	return rotation == 0 and target_letter == letter
	
		
func turn():	
	rotation_degrees += 90
	if rotation_degrees >= 360:
		rotation_degrees -= 360
	
	emit_signal("rotated")
	
	
func _on_mouse_entered():
	_set_hovering(true)
	
	
func _on_mouse_exited():
	if not draggable.dragging:
		_set_hovering(false)
	
	
func _on_picked():	
	drag_sound.play()
	z_index = 100
	emit_signal("picked", null)

	
	
func _on_dropped(_area):	
	var parent = get_parent()
	parent.remove_child(self)
	parent.add_child(self)
	z_index = 0
	
	emit_signal("dropped")
