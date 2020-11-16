extends Node2D


onready var _animation = $AnimationPlayer

func _ready():
	_animation.play("Default")
	yield(_animation, "animation_finished")
	queue_free()
