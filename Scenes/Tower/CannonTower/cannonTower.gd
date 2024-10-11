class_name CannonTower
extends Tower

func _ready() -> void:
	super._ready()
	setTowerStats("cannon")
	initStats = true

func _process(delta: float) -> void:
	cancelSelection()
	setTowerStats("cannon")
	if attackRange.target and attackCooldown(delta) and gunPivot.startShooting:
		projectileSpawner.shoot()
		startTweening(0.1,0.5)

func _input(event: InputEvent) -> void:
	mouseSelect(event)

		
