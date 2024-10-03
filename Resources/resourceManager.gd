extends CanvasLayer

var coins
var gems
var round

@onready var control: Control = $Control

func _ready():
	resourcesInit()

func resourcesInit():
	coins = 0
	gems = 0
	round = 1
	
#region INFO Resource Manager Methods
func changeRound(value: int):
	round += value
	control.updateRound(round)
func changeCoins(value: int):
	coins += value
	control.updateCoins(coins)
func changeGems(value: int):
	gems += value
	control.updateGems(gems)
#endregion


#region CAUTION - DEBUG ONLY - DONT FORGET TO REMOVE
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_text_backspace"):
		changeRound(+1)
	if event.is_action_pressed("ui_page_down"):
		changeCoins(+1)
	if event.is_action_pressed("ui_page_up"):
		changeGems(+1)
#endregion
