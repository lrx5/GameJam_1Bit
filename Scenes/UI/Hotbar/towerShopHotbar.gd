extends CanvasLayer

@export var gridSize	 	: Vector2 = Vector2(18,18)

@onready var world 			= get_tree().get_first_node_in_group("world")
@onready var towerField 	= get_tree().get_first_node_in_group("towerField")
@onready var tileMap 		= get_tree().get_first_node_in_group("tileMap")

@onready var previewTower 	: Node
@onready var buildMode 		: bool = SceneInteraction.buildMode
@onready var clicked	 	: bool = false
@onready var isDragging		: bool = false
@onready var canDrop		: bool = false
@onready var hasTowerBase 	: bool = false
@onready var canPlaceTower	: bool = true

var towerType
var towerName
var towerBase#

#region New TowerShop Variables
#var openedPos = offset.x
#var closedPos = offset.x + 80.0
#var isShopOpen = false
#var isTweening = false
#@onready var tween
#endregion

func _ready():
	#setDefaultPos()
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

func onShopHUDentered(input, panel):
	#Turn on selection toggle
	SceneInteraction.toggleSelect(true,panel.global_position + panel.get_rect().size/2)
	#Selecting tower based on the name of the main node
	match panel.name:
		"CannonPanel":
			#replace the towerType with the actual tower scene
			towerType = SceneManager.getScene("cannonTower")
		"BeamPanel":
			towerType = SceneManager.getScene("beamTower")
		"RocketPanel":
			towerType = SceneManager.getScene("rocketTower")

			
			
	if towerType and buildMode:
		if isJustClicked(input):
			if not previewTower:
				previewTower = towerType.instantiate()
				towerName = previewTower.name
			clicked = true

func _process(_delta: float) -> void:
	buildMode = SceneInteraction.buildMode
	
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
	towerField.add_child(previewTower)
	var attackRange = previewTower.get_node_or_null("AttackRange").attackRange
	
	previewTower.process_mode 		= Node.PROCESS_MODE_DISABLED
	previewTower.name 				+= "Preview"
	previewTower.modulate 			= Color("a5a5a596")
	previewTower.global_position 	= gridPlacement()
	isDragging = true

func draggedTower():
	previewTower.global_position = gridPlacement()

func droppedTower():
	previewTower.process_mode		= Node.PROCESS_MODE_ALWAYS
	previewTower.name				= towerName
	previewTower.modulate			= Color("ffffff")
	previewTower.global_position	= gridPlacement()
	SceneInteraction.toggleSelect(false)
	SceneInteraction.toggleBuildMode(false)
	previewTower = null
	isDragging = false
	towerBase = null

func cancelDrag():
	towerBase = null
	SceneInteraction.toggleSelect(false)
	SceneInteraction.toggleBuildMode(false)
	isDragging = false
	canDrop = false
	if previewTower:
		previewTower.queue_free()
		previewTower = null
	
func gridPlacement(): #Preparation for future use
	var mousePos = tileMap.get_global_mouse_position()
	#convert the mouse position to tile position
	var tilePos = tileMap.local_to_map(mousePos)
	#convert the tile position to a global position being centered around the tile position
	var cellPos = tileMap.map_to_local(tilePos) #multiplied since the tilemap is also scaled down to 0.25. If it is not scaled down there is no need to do this
	return cellPos

func onMouseEnter():
	#buildMode = true
	canDrop = false
	SceneInteraction.toggleBuildMode(true)
	InputMap.action_erase_events("shoot")
	

func onMouseExit():
	if not isDragging:
		SceneInteraction.toggleBuildMode(false)
		SceneInteraction.toggleSelect(false)
		var leftClick = InputEventMouseButton.new()
		leftClick.button_index = MOUSE_BUTTON_LEFT
		InputMap.action_add_event("shoot",leftClick)
	else:
		canDrop = true




#region Open & Close Tower Shop - TESTING
#func setDefaultPos():
#	offset.x = closedPos
#
#func _on_shop_button_pressed() -> void:
#	if isTweening == false:
#		isTweening = true
#		isShopOpen = !isShopOpen
#		if isShopOpen:
#			openTowerShop()
#			closeTowerShop()
#
#func openTowerShop():
#	tween = create_tween()
#	tween.set_trans(Tween.TRANS_CUBIC).tween_property(self, "offset:x", openedPos, 1.0)
#	tween.finished.connect(_on_tween_finished)
#	
#func closeTowerShop():
#	tween = create_tween()
#	tween.set_trans(Tween.TRANS_CUBIC).tween_property(self, "offset:x", closedPos, 1.0)
#	tween.finished.connect(_on_tween_finished)
#
#func _on_tween_finished():
#	isTweening = false
#endregion
