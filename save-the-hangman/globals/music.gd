extends AudioStreamPlayer

func _ready():
	volume_db = -5
	stream = load("res://levels/variation_1.ogg")
	play()


func play_from_start(music):
	stream = music
	play()
	
		
func continue_playing(music):
	var position = get_playback_position()
	stream = music
	play(position)
