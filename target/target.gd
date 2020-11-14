extends StaticBody2D

signal correct_letter


export var target_letter = 'A'

var current_letter = null

onready var _drop_area = $DropArea
onready var _animation = $AnimationPlayer

func _ready():
	$DropArea.connect("item_picked", self, "pick_letter")
	$DropArea.connect("item_dropped", self, "drop_letter")
	$DropArea.connect("is_hovering_changed", self, "_on_is_hovering_changed")


func pick_letter(_letter):
	current_letter = null
	_drop_area.disabled = false
	_animation.play("HoverIn")
	
	
func drop_letter(letter):
	current_letter = letter.owner
	_drop_area.disabled = true
	_animation.play_backwards("HoverIn")
	
	if is_correct_letter():
		emit_signal("correct_letter")
		

func is_correct_letter():
	return current_letter != null and current_letter.letter == target_letter
	
func _on_is_hovering_changed(is_hovering):
	if is_hovering:
		_animation.play("HoverIn")
	else:
		_animation.play_backwards("HoverIn")
		
