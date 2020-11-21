extends KinematicBody2D

export var rotation_speed = 1
export var speed = 100

var move = false

onready var screen_size = OS.get_screen_size()
onready var motion = screen_size.normalized() * speed

func _ready():
	pass
	
func _physics_process(delta):
	if not move:
		return
		
	rotation += delta * rotation_speed
	
	var collision = move_and_collide(motion * delta)
	
	if collision != null:
		rotation_speed = -rotation_speed
		motion = motion.bounce(collision.normal).normalized() * speed


func start():
	move = true
