extends StaticBody2D


var current_letter = null

onready var _animation = $AnimationPlayer

func _ready():
	$DropArea.connect("area_entered", self, "_on_area_entered")
	$DropArea.connect("area_exited", self, "_on_area_exited")
	$DropArea.connect("item_picked", self, "pick_letter")
	$DropArea.connect("item_dropped", self, "drop_letter")

func pick_letter(letter):
	current_letter = null
	_animation.play("HoverIn")
	
	
func drop_letter(letter):
	current_letter = letter
	_animation.play_backwards("HoverIn")
		

func _on_area_entered(area: Area2D):
	_animation.play("HoverIn")
	
func _on_area_exited(_area: Area2D):
	_animation.play_backwards("HoverIn")

