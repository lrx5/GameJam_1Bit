extends CanvasLayer

var coins
var gems
var round
@onready var coins_label: Label = $Control/CoinsLabel
@onready var gems_label: Label = $Control/GemsLabel
@onready var round_label: Label = $Control/RoundLabel

func _ready():
	labelsInit()

func labelsInit():
	updateRound()
	updateCoins()
	updateGems()

func _process(_delta):
	coins_label.text = str(ResourceManager.coins)

func updateRound():
	var new_round = ResourceManager.round
	var roman_numeral = to_roman_numeral(new_round)
	round_label.text = roman_numeral
func updateCoins():
	var new_coins = ResourceManager.coins
	coins_label.text = str(new_coins)
func updateGems():
	var new_gems = ResourceManager.gems
	gems_label.text = str(new_gems)

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
