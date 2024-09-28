class_name TowerPanel
extends Panel

@export var towerName : String	##Known Scene Root Name of the Tower
@onready var towerField : Node = get_tree().get_first_node_in_group("towerField")
var tower
var tempTower

func _ready():
	if towerName:
		tower = SceneManager.getScene(towerName)
	else:
		push_error("Tower name not set")

func _onUserInterfaceInput(event: InputEvent) -> void:
	tempTower = tower.instantiate()
	#Checks if the mouse hovers the panel and if the mouse button is pressed
	if event is InputEventMouseButton and event.button_mask == 1:
		add_child(tempTower)
		tempTower.process_mode = Node.PROCESS_MODE_DISABLED
		#print("Left Mouse Click")
	
	elif event is InputEventMouseMotion and event.button_mask == 1:
		get_child(1).global_position = event.global_position
		print("Left Mouse Drag")
		
	elif event is InputEventMouseButton and not event.button_mask:
		print("Left Mouse Release")
		get_child(1).queue_free()
		towerField.add_child(tempTower)
		tempTower.global_position = event.global_position
		tempTower.get_node("AttackRangeUI").hide()
