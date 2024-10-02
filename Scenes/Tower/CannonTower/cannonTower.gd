class_name CannonTower
extends Tower


func _process(delta: float) -> void:
	if attackRange.target and attackCooldown(delta) and gunPivot.startShooting:
		projectileSpawner.shoot()
		


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
