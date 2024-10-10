extends Node

var mainFR  = [1.25,1,0.6,0.4,0.15]
var mainDMG = [50,75,100,125,150]
var mainRNG = [6,7,8,11.5,15]

var main_turret_label = {
	"firerate1": "                        0.5s >>> 0.7s        Cost: 1 Gem",
	"firerate2": "                        0.7s >>> 0.9s        Cost: 1 Gem",
	"firerate3": "                        0.9s >>> 1.2s        Cost: 2 Gem",
	"firerate4": "                        1.2s >>> 1.5s        Cost: 3 Gem",
	"firerate5": "                        Max Level",
	
	"damage1": "                        50 >>> 75        Cost: 1 Gem",
	"damage2": "                        75 >>> 100        Cost: 1 Gem",
	"damage3": "                        100 >>> 125        Cost: 2 Gem",
	"damage4": "                        125 >>> 150        Cost: 3 Gem",
	"damage5": "                        Max Level",

	"range1": "                        Med >>> Med+        Cost: 1 Gem",
	"range2": "                        Med+ >>> Far-        Cost: 1 Gem",
	"range3": "                        Far- >>> Far+        Cost: 2 Gem",
	"range4": "                        Far+ >>> Global        Cost: 3 Gem",
	"range5": "                        Max Level",
}

func get_main_turret_stats(turret_stat: String, level: int) -> String:
	var mainKey = turret_stat + str(level)
	if main_turret_label.has(mainKey):
		return str(main_turret_label[mainKey])
	else:
		return ""

var turret_data = {
	"cannon1": {"price": 20, "hp": 300, "fire_rate": 1, "damage": 8, "range": 4},
	"cannon2": {"price": 20, "hp": 400, "fire_rate": 2, "damage": 12, "range": 4.5},
	"cannon3": {"price": 60, "hp": 500, "fire_rate": 3, "damage": 13, "range": 5},
	
	"rocket1": {"price": 30, "hp": 200, "fire_rate": 0.5, "damage": 40, "range": 5.5},
	"rocket2": {"price": 40, "hp": 200, "fire_rate": 0.5, "damage": 60, "range": 5.5},
	"rocket3": {"price": 70, "hp": 250, "fire_rate": 0.5, "damage": 100, "range": 5.5},
	
	"beam1": {"price": 40, "hp": 100, "fire_rate": 8, "damage": 4, "range": 2.5},
	"beam2": {"price": 50, "hp": 125, "fire_rate": 11, "damage": 4, "range": 2.5},
	"beam3": {"price": 100, "hp": 150, "fire_rate": 15, "damage": 5, "range": 3.5},
}

func get_turret_stats(turret_type: String, level: int) -> Dictionary:
	var key = turret_type + str(level)
	if turret_data.has(key):
		return turret_data[key]
	else:
		return {} 
