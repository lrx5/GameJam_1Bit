class_name CharacterState
extends Node

signal changeState
@onready var character = self

func _ready() -> void:
	#Determines what kind of character is the parent
	while character is not Characters:
		character = character.get_parent()

func _enter():
	pass
	
func _exit():
	pass
	
func _processState(delta):
	pass
	
func _processPhysics(delta):
	pass
