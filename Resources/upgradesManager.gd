extends Node
var selected_turret_position : Vector2
var is_clicked = false

# TODO - Change Range Values!
var turret_data = {
	"cannon1": {"price": 20, "hp": 300, "fire_rate": 2, "damage": 8, "range": 0},
	"cannon2": {"price": 20, "hp": 420, "fire_rate": 2, "damage": 12, "range": 0},
	"cannon3": {"price": 60, "hp": 500, "fire_rate": 3, "damage": 13, "range": 0},
	
	"rocket1": {"price": 30, "hp": 200, "fire_rate": 0.5, "damage": 40, "range": 0},
	"rocket2": {"price": 40, "hp": 200, "fire_rate": 0.5, "damage": 60, "range": 0},
	"rocket3": {"price": 70, "hp": 250, "fire_rate": 0.5, "damage": 100, "range": 0},
	
	"beam1": {"price": 40, "hp": 100, "fire_rate": 8, "damage": 4, "range": 0},
	"beam2": {"price": 50, "hp": 125, "fire_rate": 11, "damage": 4, "range": 0},
	"beam3": {"price": 100, "hp": 150, "fire_rate": 15, "damage": 5, "range": 0},
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
