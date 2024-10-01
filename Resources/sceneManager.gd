class_name ProjectSceneReferences
extends Node
##Singleton reference for all the scenes. To add a new entry in the singleton scene 
##reference, add a new export variable with a name that uses its file name and set 
##the data type as PackedScene @export var myScene : PackedScene

@export var enemy 					: PackedScene
@export var mainTower 				: PackedScene
@export var mainTowerQuadrant 		: PackedScene
@export var projectileType1 		: PackedScene
@export var towerShopHotbar 		: PackedScene
@export var tower1Panel 			: PackedScene
@export var mainMenuTextRect		: PackedScene
@export var settingsTextRect		: PackedScene
@export var world					: PackedScene
@export var gameHUD					: PackedScene

#To update the dictionary simply make the variable name as string then use it
#as the key, and the variable itself as the value

@onready var scenes : Dictionary = {
	"enemy"						: enemy,
	"mainTower"					: mainTower,
	"mainTowerQuadrant"			: mainTowerQuadrant,
	"projectileType1"			: projectileType1,
	"towerShopHotbar"			: towerShopHotbar,
	"tower1Panel"				: tower1Panel,
	"mainMenuTextRect"			: mainMenuTextRect,
	"settingsTextRect"			: settingsTextRect,
	"world"						: world,
	"gameHUD"					: gameHUD,
}

func getScene(sceneName : String): 
	#Find stringname of the known scene. Returns null if not found.
	var tempScene = scenes.get(sceneName,null)
	
	if tempScene:
		return tempScene
	else:
		print("Scene Not Found or Incorrect spelling")
