extends CanvasLayer

var round = 1
@onready var round_label: Label = $Control/RoundLabel

func _ready():
	updateRound(round)  # Initialize round_label on game start

# Convert and update the label with the round number
func updateRound(new_round: int) -> void:
	round = new_round
	var roman_numeral = to_roman_numeral(round)
	round_label.text = roman_numeral

# Function to convert number to roman numeral
func to_roman_numeral(num: int) -> String:
	var values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
	var numerals = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
	var result = ""
	var i = 0
	
	while num > 0:
		if num >= values[i]:
			num -= values[i]
			result += numerals[i]
		else:
			i += 1
			
	return result
