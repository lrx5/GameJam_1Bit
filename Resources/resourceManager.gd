extends Node

var coins
var gems
var round 

var gameHUD

func _ready() -> void:
	resourcesInit()

func resourcesInit():
	coins = 0
	gems = 0
	round = 1

func changeRound(value: int):
	round += value
	# Try to get gameHUD if it doesn't already exist
	if gameHUD == null:
		var potential_gameHUD = get_node_or_null("/root/SceneSwitcher/GameHUD")
		if potential_gameHUD:
			gameHUD = potential_gameHUD

	# If gameHUD exists, update it
	if gameHUD:
		gameHUD.updateRound(round)
	else:
		print("GameHUD not yet available")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_text_backspace"):
		changeRound(1)
