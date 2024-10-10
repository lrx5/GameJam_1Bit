class_name BeamTower
extends Tower


func _ready() -> void:
	super._ready()
	setTowerStats("beam")
	initStats = true
	
func _process(delta: float) -> void:
	setTowerStats("beam")
	
	if attackRange.target and attackCooldown(delta) and gunPivot.startShooting:
		projectileSpawner.shoot()
	
func _input(event: InputEvent) -> void:
	mouseSelect(event)
