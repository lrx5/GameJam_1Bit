extends CanvasLayer

@export var bus_name_bgm: String
@export var bus_name_sfx: String
var bus_index_bgm: int
var bus_index_sfx: int
var value = 0.5
@export var bgm: AudioStreamPlayer
@export var sfx: AudioStreamPlayer
@export var closeButton : TextureButton

func _ready() -> void:
	visible = false
	bus_index_bgm = AudioServer.get_bus_index(bus_name_bgm)
	bus_index_sfx = AudioServer.get_bus_index(bus_name_sfx)
	valuesInit()
	if closeButton:
		closeButton.connect("pressed",onClose)

func valuesInit():
	AudioServer.set_bus_volume_db(
		bus_index_bgm,
		linear_to_db(value)
	)
	AudioServer.set_bus_volume_db(
		bus_index_sfx,
		linear_to_db(value)
	)
func _on_bgm_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index_bgm,
		linear_to_db(value)
	)

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index_sfx,
		linear_to_db(value)
	)

func onClose():
	visible = false
	SceneInteraction.toggleBuildMode(false)
	await get_tree().create_timer(0.25).timeout
