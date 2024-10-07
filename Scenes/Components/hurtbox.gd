class_name Hurtbox
extends Area2D


@export_range(1,20,1, "or_greater") var immunityDuration : int = 2	##Immunity duration in counts of frames

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

func receiveDamage(damage: float, knockback: Vector2 = Vector2.ZERO):
	if not immune:
		health.currentHealth -= damage
		if health.currentHealth > 0:
			if character is Enemy:
				character.knockbackDir = knockback
				character.hurtBool = true
			else: 
				print("Damaged Received should be:",damage)
				print("Current Health: ", health.currentHealth)
		else:
			if character is Enemy:
				character.deathBool = true
			character.queue_free()
			
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
			if character is Enemy:
				character.hurtBool = false
			immune = false
			immunityCounter = 0
