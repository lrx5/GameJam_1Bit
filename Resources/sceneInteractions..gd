class_name ProjectInteractions
extends Node

signal buildModeToggle(inBuildMode: bool)
signal selectionToggle(selected: bool, globalPos: Vector2)
signal upgradeToggle(isUpgrading: bool, tower : Tower)

@export var select 		: Sprite2D
@export var upgradePanel: PanelContainer

@onready var buildMode 		: bool = false
@onready var isSelecting	: bool = false

func _ready() -> void:
	connect("buildModeToggle",onBuildModeToggle)
	connect("selectionToggle",onSelection)
	connect("upgradeToggle",onUpgradeToggle)

func toggleSelect(selected : bool, globalPos: Vector2 = Vector2.ZERO):
	emit_signal("selectionToggle", selected, globalPos)

func toggleBuildMode(inBuildMode: bool):
	emit_signal("buildModeToggle", inBuildMode)

func toggleUpgrade(isUpgrading: bool, tower: Tower = null):
	emit_signal("upgradeToggle", isUpgrading, tower)

func onBuildModeToggle(inBuildMode: bool):
	if inBuildMode:
		buildMode = true
		InputMap.action_erase_events("shoot")
	else:
		buildMode = false
		var leftClick = InputEventMouseButton.new()
		leftClick.button_index = MOUSE_BUTTON_LEFT
		InputMap.action_add_event("shoot",leftClick)

func onSelection(selected : bool, globalPos: Vector2):
	if selected:
		isSelecting = selected
		select.visible = selected
		
		select.global_position =  globalPos
	else:
		isSelecting = selected
		select.visible = selected

func onUpgradeToggle(isUpgrading: bool, tower: Tower):
	if tower:
		upgradePanel.setTower(tower)
		onBuildModeToggle(isUpgrading)
		setPanelPosition(tower)
		upgradePanel.visible = isUpgrading
		upgradePanel.process_mode = PROCESS_MODE_ALWAYS
		var target = tower.attackRange.targetPriority
		upgradePanel.targetIndex = upgradePanel.targetOptions.find_key(target)
		upgradePanel.setTarget(upgradePanel.targetIndex)
		
func setPanelPosition(tower: Tower):
	var cellSize = Vector2(18,18)
	var panelSize = upgradePanel.get_rect().size 
	var towerOffset = tower.get_global_transform_with_canvas().origin + Vector2(cellSize.x,-panelSize.y/2)
	var viewPortLimit = get_viewport().size/2
	upgradePanel.global_position = towerOffset
	
	if towerOffset.x + (4*panelSize.x) > viewPortLimit.x:
		upgradePanel.global_position.x = towerOffset.x - (2 * cellSize.x+panelSize.x)
	if towerOffset.y < 0:
		upgradePanel.global_position.y = towerOffset.y + panelSize.y/2 - cellSize.y/2
	if towerOffset.y + 2*panelSize.y > viewPortLimit.y:
		upgradePanel.global_position.y = towerOffset.y - panelSize.y/2 + cellSize.y/2
		
