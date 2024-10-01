extends CanvasLayer

@export var gridSize	 	: Vector2 = Vector2(18,18)

@onready var world 			= get_tree().get_first_node_in_group("world")
@onready var towerField 	= get_tree().get_first_node_in_group("towerField")
@onready var tileMap 		= get_tree().get_first_node_in_group("tileMap")

@onready var previewTower 	: Node
@onready var buildMode 		: bool = false
@onready var clicked	 	: bool = false
@onready var isDragging		: bool = false
@onready var canDrop		: bool = false
@onready var hasTowerBase 	: bool = false
@onready var canPlaceTower	: bool = true

var towerType
var towerName
var towerBase

# Tween variables On Shop Open & Close
var openedPos = offset.x
var closedPos = offset.x + 80.0
var isShopOpen = false
var isTweening = false
@onready var tween

func _ready():
	setDefaultPos()
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
	

func _process(_delta: float) -> void:
	if clicked:
		clickedTower()
		
	if isDragging:
		draggedTower()
		if previewTower and not towerBase:
			getFootprint(previewTower)
			
		checkOverlap()
		
		if canDrop and canPlaceTower:
			if Input.is_action_just_released("ui_LMB"):
				droppedTower()
	if Input.is_action_just_pressed("ui_RMB") and isDragging:
		cancelDrag()
		

func getFootprint(parent):
	for child in parent.get_children():
		if child is TowerBase:
			towerBase = child
			checkOverlap()
				
func checkOverlap():
	if towerBase:
		towerBase.process_mode = Node.PROCESS_MODE_ALWAYS
		if towerBase.has_overlapping_areas():
			canPlaceTower = false
		else:
			canPlaceTower = true

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
	previewTower.global_position = getSnappedCanvasMousePos()
	
func droppedTower():
	remove_child(previewTower)
	towerField.add_child(previewTower)
	previewTower.process_mode		= Node.PROCESS_MODE_ALWAYS
	previewTower.name				= towerName
	previewTower.modulate			= Color("ffffff")
	previewTower.global_position	= getSnappedCanvasMousePos()
	previewTower = null
	isDragging = false
	towerBase = null
	
func cancelDrag():
	towerBase = null
	buildMode = false
	isDragging = false
	canDrop = false
	if previewTower:
		previewTower.queue_free()
		previewTower = null
	
	
func getSnappedCanvasMousePos():
	return get_viewport().get_mouse_position().snapped(gridSize)

func gridPlacement(): #Preparation for future use
	var mousePos = get_viewport().get_mouse_position() / pow(tileMap.scale.x,2)
	#convert the mouse position to tile position
	var tilePos = tileMap.local_to_map(mousePos)
	#convert the tile position to a global position being centered around the tile position
	var cellPos = tileMap.map_to_local(tilePos) * tileMap.scale #multiplied since the tilemap is also scaled down to 0.25. If it is not scaled down there is no need to do this
	var globalPos = tileMap.to_global(cellPos).snapped(gridSize)
	return globalPos


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



# Open & Close Tower Shop
func setDefaultPos():
	offset.x = closedPos

func _on_shop_button_pressed() -> void:
	if isTweening == false:
		isTweening = true
		isShopOpen = !isShopOpen
		if isShopOpen:
			openTowerShop()
		else:
			closeTowerShop()

func openTowerShop():
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).tween_property(self, "offset:x", openedPos, 1.0)
	tween.finished.connect(_on_tween_finished)
	
func closeTowerShop():
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).tween_property(self, "offset:x", closedPos, 1.0)
	tween.finished.connect(_on_tween_finished)

func _on_tween_finished():
	isTweening = false
