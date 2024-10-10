class_name EnemyField
extends Node2D

const QUADRANT1 = Vector2(-1,-1)
const QUADRANT2 = Vector2(1 ,-1)
const QUADRANT3 = Vector2(1 , 1)
const QUADRANT4 = Vector2(-1, 1)

var quadrants = [QUADRANT1,QUADRANT2,QUADRANT3,QUADRANT4]

var vps 
var vpsWidth
var vpsHeight

@onready var canSpawn : bool = true

var bigCount
var mediumCount
var fastCount
var explodeCount

var newEnemyBig
var newEnemyMedium
var newEnemyFast
var newEnemyExplode

var waveTimer : float = 90
var waveNumber : int = 0


func _ready():
	randomize()
	quadrants.shuffle()
	setVPSvar()
	
func _process(delta):
	waveTimer += delta
	if waveTimer >= 20:
		canSpawn = true
		waveNumber += 1
		bigCount = null
		mediumCount = null
		fastCount = null
		explodeCount = null
		var wavesData = WaveManager.waves_data[waveNumber]
		mediumCount = wavesData[0]
		bigCount = wavesData[1] if wavesData.size() >= 2 else 0
		fastCount = wavesData[2] if wavesData.size() >= 3 else 0
		explodeCount = wavesData[3] if wavesData.size() >= 4 else 0
		waveTimer = 0
		ResourceManager.round += 1
		
	else:
		canSpawn = false
		
	if canSpawn:
		for i in range(bigCount):
			enemyBigSpawner()
			await get_tree().create_timer(1).timeout
		for i in range(mediumCount):
			enemyMediumSpawner()
			await get_tree().create_timer(1).timeout
		for i in range(fastCount):
			enemyFastSpawner()
			await get_tree().create_timer(1).timeout
		for i in range(explodeCount):
			enemyExplodeSpawner()
			await get_tree().create_timer(1).timeout
			
			
func enemyBigSpawner():
	newEnemyBig = SceneManager.enemyBig.instantiate() as Enemy
	add_child(newEnemyBig)
	newEnemyBig.name = "Big"
	newEnemyBig.global_position = getRandPosition(getRandQuadrant())
	newEnemyBig = null
	
func enemyMediumSpawner():
	newEnemyMedium = SceneManager.enemyMedium.instantiate() as Enemy
	add_child(newEnemyMedium)
	newEnemyMedium.name = "Medium"
	newEnemyMedium.global_position = getRandPosition(getRandQuadrant())
	newEnemyMedium = null

func enemyFastSpawner():
	newEnemyFast = SceneManager.enemyFast.instantiate() as Enemy
	add_child(newEnemyFast)
	newEnemyFast.name = "Fast"
	newEnemyFast.global_position = getRandPosition(getRandQuadrant())
	newEnemyFast = null

func enemyExplodeSpawner():
	newEnemyExplode = SceneManager.enemyExplode.instantiate() as Enemy
	add_child(newEnemyExplode)
	newEnemyExplode.name = "Explode"
	newEnemyExplode.global_position = getRandPosition(getRandQuadrant())
	newEnemyExplode = null


func setVPSvar():
	vps = get_viewport_rect().size #VPS (viewportsize)
	vpsWidth= vps.x/2
	vpsHeight = vps.y/2



func getRandQuadrant():
	var quadrant
	if waveNumber <= 10:
		quadrant = quadrants[0]
	elif waveNumber > 10 and waveNumber <= 20:
		match randi() % 2:
			0:
				quadrant = quadrants[0]
			1:
				quadrant = quadrants[1]
	elif waveNumber > 20 and waveNumber <= 30:
		match randi() % 3:
			0:
				quadrant = quadrants[0]
			1:
				quadrant = quadrants[1]
			2:
				quadrant = quadrants[2]
				
	elif waveNumber > 30:
		match randi() % 4:
			0:
				quadrant = quadrants[0]
			1:
				quadrant = quadrants[1]
			2:
				quadrant = quadrants[2]
			3:
				quadrant = quadrants[3]
				
	return quadrant

func getRandPosition(quadrant):
	var x : float = 0
	var y : float = 0
	
	var minX : float = 0
	var maxX : float = 0
	var minY : float = 0
	var maxY : float = 0
	
	if randi() % 2 == 0:
		minX = (sign(quadrant.x) * vpsWidth) + (sign(quadrant.x) * 50)
		maxX = sign(quadrant.x)
		minY = (sign(quadrant.y) * vpsHeight) + (sign(quadrant.y) * 50)
		maxY = (sign(quadrant.y) * vpsHeight) - (sign(quadrant.y) * 25)
		
		x = randf_range(minX,maxX)
		y = randf_range(minY,maxY)
		
	else:
		minX = (sign(quadrant.x) * vpsWidth) + (sign(quadrant.x) * 50)
		maxX = (sign(quadrant.x) * vpsWidth) - (sign(quadrant.x) * 25)
		minY = (sign(quadrant.y) * vpsHeight) + (sign(quadrant.y) * 50)
		maxY = sign(quadrant.y)
		
		x = randf_range(minX,maxX)
		y = randf_range(minY,maxY)
	
	return Vector2(x,y)
