class_name MainTower
extends Tower

@export var quadrant1: MainTowerQuadrant
@export var quadrant2: MainTowerQuadrant
@export var quadrant3: MainTowerQuadrant
@export var quadrant4: MainTowerQuadrant

var quad1Health : float = 0

func _ready():
	print(quadrant1.healthManager.currentHealth)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		quadrant1.healthManager.currentHealth -= 1
		print(quadrant1.healthManager.currentHealth)
		print(quadrant2.healthManager.currentHealth)
