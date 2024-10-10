class_name SceneSwitcher
extends Node

@export var mainMenuScene : CanvasLayer	##Reference to main menu
@export var settingsScene : CanvasLayer ##Reference to settings

var worldScene
var towerShopHotbar
var gameHUD

var menuControls
var newGame: bool = false

func _ready():
	mainMenu()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		settingsScene.visible = false
	
func _process(_delta: float) -> void:
	if SceneInteraction.gameEnd:
		gameEnd()
		var endScreen = SceneManager.getScene("gameEnd").instantiate()
		if SceneInteraction.gameEnd:
			add_child(endScreen)
		if not endScreen.lose.visible:
			endScreen.lose.visible = true
		SceneInteraction.gameEnd = false
		await get_tree().create_timer(5).timeout
		newGame = true
		await get_tree().create_timer(0.017).timeout
		newGame = false
		remove_child(endScreen)
	if newGame:
		add_child(mainMenuScene)

func mainMenu():
	
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
	

func gameEnd():
	if is_instance_valid(worldScene):
		worldScene.queue_free()
	if is_instance_valid(towerShopHotbar):
		towerShopHotbar.queue_free()
	if is_instance_valid(gameHUD):
		gameHUD.queue_free()

func onPressPlay():
	remove_child(mainMenuScene)
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
