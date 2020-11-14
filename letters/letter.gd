tool
extends KinematicBody2D

const LETTERS = {
	'A': 0,
	'B': 1,
	'C': 2
}
const LETTER_HEIGHT = 32
const LETTER_WIDTH = 32

export var letter:String = 'A' setget _set_letter 
func _set_letter(new_letter):
	if new_letter < 'A' or new_letter > 'C':
		print("invalid letter " + new_letter)
		return
		
	letter = new_letter

	$Sprite.region_rect = Rect2(LETTER_WIDTH * LETTERS[letter], 0, LETTER_WIDTH, LETTER_HEIGHT)
	
