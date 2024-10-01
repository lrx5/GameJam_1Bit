class_name Characters
extends CharacterBody2D

@export_category("Node References")
@export var animTree 		: AnimationTree
@export var healthManager 	: HealthManager
@export var moveStateMach 	: MoveStateMachine
@export var actionStateMach : ActionStateMachine

@export_category("Character Variables")
@export_range(0,150,1,"or_greater") var runSpeed 	: float = 125
@export_range(0,25,1,"or_greater") var accel		: float = 10
@export_range(0,25,1,"or_greater") var fric			: float = 15

var direction : Vector2

@onready var hasDied : bool = false
