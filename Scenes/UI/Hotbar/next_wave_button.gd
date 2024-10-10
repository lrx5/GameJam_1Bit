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
		enemyField.waveTimer = 90
