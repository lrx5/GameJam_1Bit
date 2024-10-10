class_name RocketTower
extends Tower


func _ready() -> void:
	super._ready()
	setTowerStats("rocket")
	initStats = true

func _process(delta: float) -> void:
	setTowerStats("rocket")
	
	if attackRange.target and attackCooldown(delta) and gunPivot.startShooting:
		projectileSpawner.shoot()
		
func _input(event: InputEvent) -> void:
	mouseSelect(event)
