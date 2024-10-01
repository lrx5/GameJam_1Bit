class_name Hurtbox
extends Area2D

@export var health 				: HealthManager 
@export_range(1,20,1, "or_greater") var immunityDuration : int = 2

@onready var hit 				: bool = false
@onready var startImmunityCounter : bool = false

@onready var immune	: bool	= false
var character = self
var immunityCounter : float = 0


func _ready() -> void:
	_getCharacter()
	if not health:
		push_error("You forgot to add the Health Manager")

func _process(delta: float) -> void:
	_startImmunity(delta)

func receiveDamage(damage: float):#, knockback: float):
	if not immune:
		health.currentHealth -= damage
		if health.currentHealth <= 0:
			character.queue_free()
		#character.actionStateMach.states["Hurt"].knockbackDisplacement = knockback
		#if health.currentHealth > 0:
		#	character.hasBeenHurt = true
		#else:
		#	character.hasDied = true
		startImmunityCounter = true

func isNotDeadYet():
	return health.currentHealth > 0

func _startImmunity(delta):
	if startImmunityCounter:
		immune = true
		immunityCounter += delta
		if immunityCounter > immunityDuration * delta:
			#character.hasBeenHurt = false
			startImmunityCounter = false
			immune = false
			immunityCounter = 0

func _getCharacter(): ##Gets the parent character
	while character is not Characters:
		character = character.get_parent()
