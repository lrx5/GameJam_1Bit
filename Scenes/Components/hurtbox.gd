class_name Hurtbox
extends Area2D


@export_range(1,20,1, "or_greater") var immunityDuration : int = 2

@onready var hit 				: bool = false
@onready var startImmunityCounter : bool = false

@onready var immune	: bool	= false
@onready var character = get_parent()
var health
var immunityCounter : float = 0


func _ready() -> void:
	health = character.healthManager
	
func _process(delta: float) -> void:
	_startImmunity(delta)

func receiveDamage(damage: float, knockback: Vector2):
	if not immune:
		health.currentHealth -= damage
		if health.currentHealth > 0:
			if character is Characters:
				character.knockbackDir = knockback
			character.hurtBool = true
			
		else:
			character.deathBool = true
			
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
			character.hurtBool = false
			immune = false
			immunityCounter = 0
