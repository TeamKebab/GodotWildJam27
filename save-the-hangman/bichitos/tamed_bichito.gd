extends "res://bichitos/bichito.gd"

const SPRITES = [
	"res://bichitos/bichito.png",
	"res://bichitos/bichito_cabron.png",
	"res://bichitos/bichito_maximo.png"
]

var letter_target

func _ready():
	$Sprite.texture = load(Random.choose(SPRITES))

func get_available_letters() -> Array:
	return [target]

func pursue(new_target):
	_state_machine._change_state("Pursuing")


func pick():
	_state_machine._change_state("Placing")
	
	
func drop():
	target.drop(letter_target.drop_area)
	_state_machine._change_state("Dancing")
