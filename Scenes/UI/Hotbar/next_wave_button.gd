extends TextureButton

@onready var enemyField = get_tree().get_first_node_in_group("enemyField")

func _ready():
	connect("mouse_entered",onWaveButtonEnter)
	connect("mouse_exited",onWaveButtonExit)
	connect("pressed",onWaveButtonPressed)
	
func onWaveButtonEnter():
	SceneInteraction.toggleBuildMode(true)

func onWaveButtonExit():
	SceneInteraction.toggleBuildMode(false)

func onWaveButtonPressed():
	if enemyField.waveNumber != 50:
		await get_tree().create_timer(0.1).timeout
		enemyField.waveTimer = 90
	elif enemyField.waveNumber == 50:
		process_mode = PROCESS_MODE_DISABLED
