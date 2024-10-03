class_name Hurtbox
extends Area2D


@export_range(1,20,1, "or_greater") var immunityDuration : int = 2

@onready var hit 				: bool = false
@onready var startImmunityCounter : bool = false

@onready var immune	: bool	= false
@onready var character = get_parent()
var health
var immunityCounter : float = 0

#region New OnHit Variables - TESTING
@export var damage_particles: GPUParticles2D 
@export var damage_particles_timer: Timer 
@export var enemy_sprite: Sprite2D 
@export var on_hit_sfx: AudioStreamPlayer
var sfx_list = [
	preload("res://Assets/Sounds/Sound Effects/OnHit/damaged1.wav"),
	preload("res://Assets/Sounds/Sound Effects/OnHit/damaged2.wav"),
	preload("res://Assets/Sounds/Sound Effects/OnHit/damaged3.wav"),
]
#endregion


func _ready() -> void:
	health = character.healthManager
	
func _process(delta: float) -> void:
	_startImmunity(delta)

func receiveDamage(damage: float):#, knockback: float):
	if not immune:
		health.currentHealth -= damage
		if health.currentHealth > 0:
			character.hurtBool = true
		else:
			character.deathBool = true
		#region Call OnHit Effects - TESTING
		#onDamagedVFX()
		#onDamagedSFX()
		
		#endregion
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


#region OnHit VFX & SFX - TESTING
func onDamagedVFX():
	var black_fade = create_tween()
	black_fade.tween_method(blackFade, 1.0, 0.0, 0.3)
	damage_particles.emitting = true 
	damage_particles_timer.start()

func blackFade(newValue: float):
	enemy_sprite.material.set_shader_parameter("value", newValue)
	
func _on_damage_particles_timer_timeout() -> void:
	damage_particles.emitting = false

func onDamagedSFX():
	var random_sfx = sfx_list[randi() % sfx_list.size()]
	on_hit_sfx.stream = random_sfx
	on_hit_sfx.play()

#endregion
