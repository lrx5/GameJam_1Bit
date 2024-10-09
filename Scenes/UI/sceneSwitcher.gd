class_name SceneSwitcher
extends Node

@export var mainMenuScene : CanvasLayer		##Reference to main menu
@export var settingsScene : CanvasLayer		##Reference to settings

var worldScene
var towerShopHotbar
var gameHUD

var menuControls

@onready var gameEnded = false

func _ready():
	if mainMenuScene:
		menuControls = mainMenuScene.get_tree().get_nodes_in_group("menuControls")
		for control in menuControls:
			if mainMenuScene.is_ancestor_of(control):
				match control.name:
					"Play":
						control.connect("pressed",onPressPlay)
					"Settings":
						control.connect("pressed",onPressSettings)
					"Quit":
						control.connect("pressed",onPressQuit)
	else:
		push_error("Main Menu not assigned")
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		settingsScene.visible = false
	
func _process(_delta: float) -> void:
	if SceneInteraction.gameEnd:
		gameEnd()
		SceneInteraction.gameEnd = false

func gameEnd():
	if is_instance_valid(worldScene):
		worldScene.queue_free()
	if is_instance_valid(towerShopHotbar):
		towerShopHotbar.queue_free()
	if is_instance_valid(gameHUD):
		gameHUD.queue_free()

func onPressPlay():
	mainMenuScene.queue_free()
	worldScene = SceneManager.getScene("world").instantiate()
	towerShopHotbar = SceneManager.getScene("towerShopHotbar").instantiate()
	gameHUD = SceneManager.getScene("gameHUD").instantiate()
	add_child(worldScene)
	add_child(towerShopHotbar)
	add_child(gameHUD)

func onPressSettings():
	settingsScene.visible = true
	
func onPressQuit():
	get_tree().quit()
