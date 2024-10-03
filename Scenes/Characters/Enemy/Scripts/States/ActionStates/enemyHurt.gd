class_name EnemyHurt
extends ActionState

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

func _enter():
	print("Hurt")
	#character.velocity = character.knockbackDir * 10
	#region Call OnHit Effects - TESTING
	onDamagedVFX()
	onDamagedSFX()
	#endregion
	
func _processState(delta: float) -> void:
	character.velocity = character.knockbackDir * 10
	character.velocity.x = move_toward(character.velocity.x, 0, 1)
	character.velocity.y = move_toward(character.velocity.y, 0, 1)


	
#region OnHit VFX & SFX - TESTING
func onDamagedVFX():
	var black_fade = create_tween()
	black_fade.tween_method(blackFade, 1.0, 0.0, 0.3)
	damage_particles.global_position = character.global_position
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
