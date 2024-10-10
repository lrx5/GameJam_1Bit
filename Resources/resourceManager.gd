extends CanvasLayer

var coins
var gems
var round



func _ready():
	resourcesInit()

func resourcesInit():
	coins = 999
	gems = 99
	round = 0
	
#region INFO Resource Manager Methods
func changeRound(value: int):
	round += value
func changeCoins(value: int):
	coins += value
func changeGems(value: int):
	gems += value
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
