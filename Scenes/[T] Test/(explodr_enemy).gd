extends AnimatedSprite2D

var speed = 10
var rotation_speed = 40

@onready var damage_particles: GPUParticles2D = $DamageParticles
@onready var _explodr_enemy_: AnimatedSprite2D = $"."

func _ready():
	damage_particles.emitting = false

func _process(delta):

	rotation_degrees += rotation_speed * delta
	position.y -= speed * delta
	
	if Input.is_action_just_pressed("shoot"):
		damage_particles.emitting = true  
		ApplyDamage()
	if Input.is_action_just_released("shoot"):  
		damage_particles.emitting = false 


func ApplyDamage():
	var tween = get_tree().create_tween()
	tween.tween_method(SetDamage, 1.0, 0.0, 0.3)

func SetDamage(newValue: float):
	_explodr_enemy_.material.set_shader_parameter("value", newValue)
