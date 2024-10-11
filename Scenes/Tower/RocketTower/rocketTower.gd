class_name RocketTower
extends Tower


func _ready() -> void:
	super._ready()
	setTowerStats("rocket")
	initStats = true

func _process(delta: float) -> void:
	setTowerStats("rocket")
	
	cancelSelection()
	if attackRange.target and attackCooldown(delta) and gunPivot.startShooting:
		projectileSpawner.shoot()	
		startTweening(0.1,0.2)
		
func _input(event: InputEvent) -> void:
	mouseSelect(event)
