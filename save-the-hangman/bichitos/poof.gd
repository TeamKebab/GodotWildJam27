extends Node2D


onready var _animation = $AnimationPlayer
onready var _die_sound = $DieSound


func _ready():
	_animation.play("Default")
	_die_sound.play()
	
	yield(_animation, "animation_finished")
	queue_free()
