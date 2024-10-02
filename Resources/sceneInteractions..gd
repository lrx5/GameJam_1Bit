class_name ProjectInteractions
extends Node

signal buildModeToggle(inBuildMode: bool)
signal selectionToggle(selected: bool, globalPos: Vector2)


@export var select : Sprite2D

@onready var buildMode 		: bool = false
@onready var isSelecting	: bool = false

func _ready() -> void:
	connect("buildModeToggle",onBuildModeToggle)
	connect("selectionToggle",onSelection)

func toggleSelect(selected : bool, globalPos: Vector2 = Vector2.ZERO):
	#if selected:
	#	print("I am toggled to select")
	#else:
	#	print("I am not selecting anything")
	emit_signal("selectionToggle", selected, globalPos)

func toggleBuildMode(inBuildMode: bool):
	emit_signal("buildModeToggle", inBuildMode)

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
