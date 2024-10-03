class_name StateHandler
extends Node

@export var actionStateMach : ActionStateMachine
@export var moveStateMach 	: MoveStateMachine

@onready var character = self


func _ready():
	while not character is Characters:
		character = character.get_parent()
	character._setInitTarget()

func _process(delta: float) -> void:
	
	_handleIdle()
	_handleRun()
	_handleAttack()
	_handleHurt()
	_handleDeath()


func _handleIdle():
	if character.attackBool: 
		if moveStateMach.currentState != moveStateMach.states["Idle"]:
			moveStateMach._onChangeState(moveStateMach.currentState,moveStateMach.states["Idle"])
		
	if not character.attackBool and not character.hurtBool:
		if actionStateMach.currentState != actionStateMach.states["Idle"] and not character.attackBool:
			actionStateMach._onChangeState(actionStateMach.currentState,actionStateMach.states["Idle"])
	
func _handleRun():
	if (character.initTarget or character.target) and not character.attackBool:
		if moveStateMach.currentState != moveStateMach.states["Run"]:
			moveStateMach._onChangeState(moveStateMach.currentState,moveStateMach.states["Run"])
	
func _handleAttack():
	if character.detectBool:
		character.hitbox.process_mode = PROCESS_MODE_ALWAYS
		if character.attackBool:
			if actionStateMach.currentState != actionStateMach.states["Attack"]:
				actionStateMach._onChangeState(actionStateMach.currentState,actionStateMach.states["Attack"])
	else:
		character.hitbox.process_mode = PROCESS_MODE_DISABLED
	
func  _handleHurt():
	if character.hurtBool:
		if actionStateMach.currentState != actionStateMach.states["Hurt"]:
			actionStateMach._onChangeState(actionStateMach.currentState,actionStateMach.states["Hurt"])
	
func _handleDeath():
	if character.deathBool:
		if actionStateMach.currentState != actionStateMach.states["Death"]:
			actionStateMach._onChangeState(actionStateMach.currentState,actionStateMach.states["Death"])
