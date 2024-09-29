extends CanvasLayer

@export var gridSize	 	: Vector2 = Vector2(18,18)

@onready var world 			= get_tree().get_first_node_in_group("world")
@onready var towerField 	= get_tree().get_first_node_in_group("towerField")


@onready var previewTower 	: Node
@onready var buildMode 		: bool = false
@onready var clicked	 	: bool = false
@onready var isDragging		: bool = false
@onready var canDrop		: bool = false


var towerType
var towerName

func _ready():
	var nodeSorter = []
	_getTowers(self, nodeSorter)

func _getTowers(parent : Node, children: Array):
	#gets all the child of the towershop in the first iteration
	for child in parent.get_children():
		if child.is_in_group("buildTower"):
			child.connect("gui_input",onShopHUDentered.bind(child))
			child.connect("mouse_entered", onMouseEnter)
			child.connect("mouse_exited", onMouseExit)
			children.append(child)
		#reiterates to scan the child of the towershop's child
		_getTowers(child,children)

func onShopHUDentered(input, tower):
	#Selecting tower based on the name of the main node
	match tower.name:
		"Tower1Panel":
			#replace the towerType with the actual tower scene
			towerType = SceneManager.getScene("mainTower")
		"Tower2Panel":
			towerType = null
		"PanelTemplate":
			towerType = null
			
	if towerType and buildMode:
		if isJustClicked(input):
			if not previewTower:
				previewTower = towerType.instantiate()
				towerName = previewTower.name
			clicked = true
	

func _process(delta: float) -> void:
	if clicked:
		clickedTower()
		
	if isDragging:
		draggedTower()
		if canDrop:
			if Input.is_action_just_released("ui_LMB"):
				droppedTower()
	if Input.is_action_just_pressed("ui_RMB") and isDragging:
		cancelDrag()
	if previewTower:
		print(previewTower.get_child(0).is_colliding)
		
func isJustClicked(input: InputEvent):
	return input is InputEventMouseButton and input.button_mask == 1

func clickedTower():
	clicked = false
	add_child(previewTower) 
	previewTower.process_mode 		= Node.PROCESS_MODE_DISABLED
	previewTower.name 				+= "Preview"
	previewTower.modulate 			= Color("a5a5a596")
	previewTower.global_position 	= getSnappedCanvasMousePos()
	isDragging = true
	
func draggedTower():
	get_child(1).global_position = getSnappedCanvasMousePos()
	
func droppedTower():
	remove_child(previewTower)
	towerField.add_child(previewTower)
	previewTower.process_mode		= Node.PROCESS_MODE_ALWAYS
	previewTower.name				= towerName
	previewTower.modulate			= Color("ffffff")
	previewTower.global_position	= getSnappedCanvasMousePos()
	previewTower = null
	isDragging = false
	
func cancelDrag():
	buildMode = false
	isDragging = false
	canDrop = false
	if previewTower:
		previewTower.queue_free()
		previewTower = null
	
	
func getSnappedCanvasMousePos():
	return get_viewport().get_mouse_position().snapped(gridSize)

func onMouseEnter():
	buildMode = true
	canDrop = false
	InputMap.action_erase_events("shoot")

func onMouseExit():
	if not isDragging:
		buildMode = false
		var leftClick = InputEventMouseButton.new()
		leftClick.button_index = MOUSE_BUTTON_LEFT
		InputMap.action_add_event("shoot",leftClick)
	else:
		canDrop = true
	
