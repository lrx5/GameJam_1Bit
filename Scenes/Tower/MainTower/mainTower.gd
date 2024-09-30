class_name MainTower
extends Tower

@export_category("Tower Quadrants")
@export var quadrant1: MainTowerQuadrant
@export var quadrant2: MainTowerQuadrant
@export var quadrant3: MainTowerQuadrant
@export var quadrant4: MainTowerQuadrant

var quad1Health : float = 0


@onready var wantToShoot: bool = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		projectileSpawner.shoot()
			
