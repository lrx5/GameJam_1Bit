class_name HealthManager
extends Node

@export_range(0,100,0.5, "or_greater") var maxHealth : float = 10

@onready var currentHealth : float = maxHealth
