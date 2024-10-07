extends Node

# TODO - Change Range Values!
var turret_data = {
	"cannon1": {"price": 20, "hp": 300, "fire_rate": 2, "damage": 8, "range": 4},
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

func get_specific_turret(turret_key: String) -> Dictionary:
	if turret_data.has(turret_key):
		return turret_data[turret_key]
	else:
		print("Turret level", turret_key, "not found")
		return {}
