class_name EnemyDeath
extends ActionState



func _enter():
	print("I died")
	dropCoin()
	character.process_mode = PROCESS_MODE_DISABLED
	character.queue_free()


func dropCoin():
	match character.name:
		"EnemyBig":
			ResourceManager.changeCoins(6)
			print("dropped 6")
		"EnemyMedium":
			ResourceManager.changeCoins(1)
		"EnemyFast":
			ResourceManager.changeCoins(2)
		"EnemyExplode":
			ResourceManager.changeCoins(4)
