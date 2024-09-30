class_name SceneSwitcher
extends Node

@export var mainMenuScene : CanvasLayer		##Reference to main menu
@export var settingsScene : CanvasLayer		##Reference to settings

var menuControls

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
	
func onPressPlay():
	mainMenuScene.queue_free()
	var worldScene = SceneManager.getScene("world").instantiate()
	var towerShopHotbar = SceneManager.getScene("towerShopHotbar").instantiate()
	add_child(worldScene)
	add_child(towerShopHotbar)
	
func onPressSettings():
	settingsScene.visible = true
	
func onPressQuit():
	get_tree().quit()
