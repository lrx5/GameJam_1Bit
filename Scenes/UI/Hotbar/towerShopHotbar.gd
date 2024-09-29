extends CanvasLayer

@export var gridSize	 	: Vector2 = Vector2(18,18)

@onready var world 			= get_tree().get_first_node_in_group("world")
@onready var towerField 	= get_tree().get_first_node_in_group("towerField")
@onready var buildMode 		: bool = false
@onready var buildValid 	: bool = false
@onready var previewTower 	: Node

var buildLocation
var towerType



func _ready():
	var nodeSorter = []
	_getTowers(self, nodeSorter)

func setTowerPreview(tower: PackedScene, mousePos: Vector2):
	var towerPreview = tower.instantiate()
	towerPreview.process_mode = Node.PROCESS_MODE_DISABLED
	towerPreview.modulate = Color("a5a5a596")
	add_child(towerPreview)
	towerPreview.name += "Preview"
	towerPreview.global_position = mousePos
	
	#if towerField:
	#	towerField.add_child(towerPreview)
	#	towerPreview.name = towerName
	#	towerPreview.global_position = mousePos.snapped(gridSize)

func _getTowers(parent : Node, children: Array):
	#gets all the child of the towershop in the first iteration
	for child in parent.get_children():
		if child.is_in_group("buildTower"):
			child.connect("gui_input",onShopHUDentered.bind(child))
			child.connect("mouse_entered", onMouseEnter)
			child.connect("mouse_exited", onMouseExit)
			children.append(child)
			print(child.name)
		#reiterates to scan the child of the towershop's child
		_getTowers(child,children)

func onShopHUDentered(input, tower):
	match tower.name:
		"Tower1Panel":
			#replace the towerType with the actual tower scene
			towerType = SceneManager.getScene("mainTower")
		"Tower2Panel":
			towerType = null
			print("No towers yet")
		"PanelTemplate":
			towerType = null
			print("Come on... I'm just a template")
			
	if towerType and buildMode:
		previewTower = towerType.instantiate()
		if isJustPressed(input):
			clickedTower(input)
		elif isPressed(input):
			draggedTower(input)
		elif isJustReleased(input):
			releasedTower(input)
			buildMode = false
		elif InputEventMouseButton and not input.button_mask == 1:
			pass
			#get_child(1).queue_free()
	

func isJustPressed(input: InputEvent):
	return input is InputEventMouseButton and input.button_mask == 1
	
func isPressed(input: InputEvent):
	return input is InputEventMouseMotion and input.button_mask == 1

func isJustReleased(input: InputEvent):
	return input is InputEventMouseButton and input.button_mask == 0
	
func clickedTower(input: InputEvent):
	previewTower.process_mode 	= Node.PROCESS_MODE_DISABLED
	previewTower.modulate 		= Color("a5a5a596")
	add_child(previewTower)
	previewTower.name 			+= "Preview"
	previewTower.global_position = gridSnap(input)
	
func draggedTower(input: InputEvent):
	get_child(1).global_position = gridSnap(input)
	
func releasedTower(input: InputEvent):
	get_child(1).queue_free()
	towerField.add_child(previewTower)
	previewTower.global_position = gridSnap(input)
	
func gridSnap(input: InputEvent):
	return input.global_position.snapped(gridSize)

func onMouseEnter():
	buildMode = true
	InputMap.action_erase_events("shoot")

func onMouseExit():
	var leftClick = InputEventMouseButton.new()
	leftClick.button_index = MOUSE_BUTTON_LEFT
	InputMap.action_add_event("shoot",leftClick)
	
