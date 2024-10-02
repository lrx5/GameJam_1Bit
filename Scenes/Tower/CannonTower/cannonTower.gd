class_name CannonTower
extends Tower

var tween
@onready var cannon_sprite: Sprite2D = $GunPivot/CannonSprite

func _process(delta: float) -> void:
	if attackRange.target and attackCooldown(delta) and gunPivot.startShooting:
		projectileSpawner.shoot()
		# TESTING Turret Anim
		startTweening()

func startTweening():
	tween = create_tween()
	# Cannon Recoil
	tween.set_ease(Tween.EASE_IN_OUT).tween_property(cannon_sprite, "position:y", 2, 0.1).as_relative()
	# Cannon Recoil Reset
	tween.set_ease(Tween.EASE_IN_OUT).tween_property(cannon_sprite, "position:y", -2, 1).as_relative()
		


func onMouseEnter():
	InputMap.action_erase_events("shoot")

func onMouseExit():
	var leftClick = InputEventMouseButton.new()
	leftClick.button_index = MOUSE_BUTTON_LEFT
	InputMap.action_add_event("shoot",leftClick)

	




func _on_mouse_entered() -> void:
	print("I am hovering")



func _on_mouse_exited() -> void:
	print("Mouse not hovering anymore.")
