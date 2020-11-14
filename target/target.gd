extends StaticBody2D

export var target_letter = 'A'

var current_letter = null

onready var _animation = $AnimationPlayer

func _ready():
	$DropArea.connect("item_picked", self, "pick_letter")
	$DropArea.connect("item_dropped", self, "drop_letter")
	$DropArea.connect("is_hovering_changed", self, "_on_is_hovering_changed")


func pick_letter(letter):
	current_letter = null
	_animation.play("HoverIn")
	
	
func drop_letter(letter):
	current_letter = letter
	_animation.play_backwards("HoverIn")
		

func _on_is_hovering_changed(is_hovering):
	if is_hovering:
		_animation.play("HoverIn")
	else:
		_animation.play_backwards("HoverIn")
		
