extends TextureButton

var justClicked = false

func _ready() -> void:
	var settings = get_node("/root/SceneSwitcher/Settings")
	settings.visible = false
	connect("mouse_entered",onShopEnter)
	connect("mouse_exited",onShopExit)
	
func onShopEnter():
	SceneInteraction.toggleBuildMode(true)
	
func onShopExit():
	if not justClicked:
		SceneInteraction.toggleBuildMode(false)

	
func _on_pressed() -> void:
	
	if not justClicked:
		justClicked = true
	else:
		justClicked = false

	var settings = get_node("/root/SceneSwitcher/Settings")
	settings.visible = true
	SceneInteraction.toggleBuildMode(true)
	await get_tree().create_timer(0.25).timeout
	
