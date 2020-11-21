extends Node2D

const LOOK_ANIMATIONS = [
	"LookUp",
	"LookDown",
	"LookLeft",
	"LookRight",
	"LookFront",
	"LookFront",
	"LookFront",
	"LookFront",	
]

onready var look_around_timer = $LookAroundTimer
onready var look_around_animation = $LookAroundAnimation

onready var blink_timer = $BlinkTimer
onready var blink_animation = $BlinkAnimation

onready var talk_timer = $TalkTimer
onready var mouth = $Mouth
onready var talking_sound = $TalkingSound


func _ready():
	look_around_timer.connect("timeout", self, "look_somewhere")
	blink_timer.connect("timeout", self, "blink")
	talk_timer.connect("timeout", self, "talk")
		
	look_somewhere()
	blink()
	start_talking()


func look_somewhere():
	var direction = Random.choose(LOOK_ANIMATIONS)	
	look_around_animation.play(direction)
	
	var time = Random.randf_range(1,3)
	
	look_around_timer.start(time)


func blink():
	blink_animation.play("Blink")
	
	yield(get_tree().create_timer(0.4, 3), "timeout")
	
	blink_animation.play_backwards("Blink")
	
	var time = Random.randf_range(6,15)
	
	blink_timer.start(time)


func start_talking():
	talk_timer.start()
	talking_sound.play()
	
	
func stop_talking():
	talk_timer.stop()
	talking_sound.stop()
	mouth.frame = 3
	
	
func talk():
	mouth.frame = Random.randi(3)
	
	
