class_name EnemyDeath
extends ActionState



func _enter():
	print("I died")
	dropCoin()
	character.process_mode = PROCESS_MODE_DISABLED
	character.queue_free()


func dropCoin():
	if character.name.left(3) == "Big":
		ResourceManager.changeCoins(12)
	if character.name.left(6) == "Medium":
		ResourceManager.changeCoins(4)
	if character.name.left(4) == "Fast":
		ResourceManager.changeCoins(3)
	if character.name.left(7) == "Explode":
		ResourceManager.changeCoins(6)
