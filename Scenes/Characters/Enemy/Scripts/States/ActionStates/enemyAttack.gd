class_name Attack
extends ActionState

var frame: float = 0.01666666666666667
@onready var canStartAttacking : bool = true

var myPos
var targetPos
var myRot

var newTarget
var prevTarget


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
		
			
	if not is_instance_valid(character.target):
		print("Quadrant died")
	
	
	if character.attackBool and canStartAttacking:
		canStartAttacking = false
		character.animTree.set(character.isAttacking,AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

	
func onAttackFinished(anim: StringName):
	if anim == "Attack":
		#print("Finished attacking")
		character.damaging = true
		await get_tree().create_timer(frame).timeout
		character.damaging = false
		canStartAttacking = true
		
		if character.name == "EnemyExplode":
			character.deathBool = true

func setTarget():
	if character.target:
		if is_instance_valid(character.target):
			targetPos = character.target.global_position
	elif character.initTarget and not character.target:
		if is_instance_valid(character.initTarget):
			targetPos = character.initTarget.global_position
	
	myPos = character.global_position
	var newDirection = myPos.direction_to(targetPos)
	character.set_velocity(newDirection * character.runSpeed)
	character.rotation = newDirection.angle() - deg_to_rad(90)
