class_name ProjectSceneReferences
extends Node
##Singleton reference for all the scenes. To add a new entry in the singleton scene 
##reference, add a new export variable with a name that uses its file name and set 
##the data type as PackedScene @export var myScene : PackedScene

@export_category("Enemies")

@export_group("Enemies")
@export var enemy 					: PackedScene


@export_category("Towers")

@export_group("Towers")
@export var mainTower 				: PackedScene
@export var mainTowerQuadrant 		: PackedScene
@export var cannonTower				: PackedScene
@export var beamTower				: PackedScene
@export var rocketTower				: PackedScene

@export_subgroup("Projectiles")
@export var mainTowerProjectile		: PackedScene
@export var cannonTowerProjectile	: PackedScene
@export var beamTowerProjectile		: PackedScene
@export var rocketTowerProjectile	: PackedScene

@export_category("UI")

@export_group("Main")
@export var mainMenu				: PackedScene
@export var settings				: PackedScene
@export var world					: PackedScene
@export var gameHUD					: PackedScene

@export_group("Tower Shop")
@export var towerShopHotbar 		: PackedScene
@export var cannonPanel 			: PackedScene
@export var beamPanel				: PackedScene
@export var rocketPanel				: PackedScene


#To update the dictionary simply make the variable name as string then use it
#as the key, and the variable itself as the value

@onready var scenes : Dictionary = {
	"enemy"						: enemy,
	"mainTower"					: mainTower,
	"mainTowerQuadrant"			: mainTowerQuadrant,
	"cannonTower"				: cannonTower,
	"cannonTowerProjectile"		: cannonTowerProjectile,
	"towerShopHotbar"			: towerShopHotbar,
	"cannonPanel"				: cannonPanel,
	"mainMenu"					: mainMenu,
	"settings"					: settings,
	"world"						: world
}

func getScene(sceneName : String): 
	#Find stringname of the known scene. Returns null if not found.
	var tempScene = scenes.get(sceneName,null)
	
	if tempScene:
		return tempScene
	else:
		print("Scene Not Found or Incorrect spelling")
