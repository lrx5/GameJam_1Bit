extends GridContainer

@export_range(0,20,0.5,"or_greater") var rightOffset : float

func _ready() -> void:
	position.x -= rightOffset
