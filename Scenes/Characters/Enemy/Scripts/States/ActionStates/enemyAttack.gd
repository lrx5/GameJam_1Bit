class_name Attack
extends ActionState

var frame: float = 0.01666666666666667
@onready var canStartAttacking : bool = true


func _enter():
	if not character.animTree.is_connected("animation_finished",onAttackFinished):
		character.animTree.connect("animation_finished", onAttackFinished)
	
	if not canStartAttacking:
		character.animTree.set(character.attackTimeScale,true)
	else:
		character.animTree.set(character.isAttacking,AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
func _exit():
	if not canStartAttacking:
		character.animTree.set(character.attackTimeScale,false)
	

func _processState(delta):
	if character.get_slide_collision_count():
		if character.velocity != Vector2.ZERO:
			character.velocity = lerp(character.velocity,Vector2.ZERO,delta)
			
	if character.attackBool and canStartAttacking:
		canStartAttacking = false
		character.animTree.set(character.isAttacking,AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

	
func onAttackFinished(anim: StringName):
	if anim == "Attack":
		print("Finished attacking")
		character.damaging = true
		await get_tree().create_timer(frame).timeout
		character.damaging = false
		canStartAttacking = true
		
		
		if character.name == "EnemyExplode":
			character.deathBool = true
