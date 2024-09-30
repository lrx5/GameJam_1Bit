extends Control

@onready var main_menu = get_tree().root.get_node("Main/MainMenu")
@onready var settings = get_tree().root.get_node("Main/Settings")

func _on_play_pressed() -> void:
	CanvasManager.game_started = true
	main_menu.visible = false

func _on_settings_pressed() -> void:
	settings.visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape") and !CanvasManager.game_started:
		settings.visible = false


func _on_quit_pressed() -> void:
	get_tree().quit()
