extends TextureButton

@onready var BGM = get_node("/root/SceneSwitcher/Settings/Control/BGM")
@export var new_audio_stream: AudioStream
func _on_pressed() -> void:
	BGM.stream = new_audio_stream
	BGM.play()
