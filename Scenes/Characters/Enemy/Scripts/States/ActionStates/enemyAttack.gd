class_name Attack
extends ActionState

var frame: float = 0.01666666666

func _enter():
	if not character.animTree.is_connected("animation_finished",onAttackFinished):
		character.animTree.connect("animation_finished", onAttackFinished)
	
	character.animTree.set(character.isAttacking,AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
func _exit():
	character.animTree.set(character.isAttacking,AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)

func _processState(delta):
	if character.velocity != Vector2.ZERO:
		character.velocity = Vector2.ZERO

func onAttackFinished(anim: StringName):
	if anim == "Attack":
		character.damaging = true
		await get_tree().create_timer(frame).timeout
		character.damaging = false
		if character.name == "EnemyExplode":
			character.deathBool = true
