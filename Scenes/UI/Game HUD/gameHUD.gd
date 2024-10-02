extends Control

@onready var coins_label: Label = $CoinsLabel
@onready var gems_label: Label = $GemsLabel
@onready var round_label: Label = $RoundLabel

func _ready():
	labelsInit()

func labelsInit():
	updateRound(1)
	updateCoins(0)
	updateGems(0)

func updateRound(new_value: int) -> void:
	var roman_numeral = to_roman_numeral(new_value)
	round_label.text = roman_numeral
func updateCoins(new_value):
	coins_label.text = str(new_value)
func updateGems(new_value):
	gems_label.text = str(new_value)

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
