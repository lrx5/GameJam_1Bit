extends Sprite2D

@onready var tween
var posCenter
var posRight
var posLeft
var normal_scale = scale
var starting_scale = Vector2(0.5, 0.5)
var final_scale = starting_scale
var is_tweening = false

func _ready() -> void:
	posCenter = position					# Main Sprite Position
	posRight = posCenter + Vector2(25, 0)	# Right Position
	posLeft = posCenter - Vector2(25, 0)	# Left Position
	
	position = posRight 					# Start Right Position
	scale = starting_scale					# Start Scale at 0.5, 0.5
	modulate.a = 0							# Starting Modulate
func _right_center() -> void:
	tween = create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_CUBIC).tween_property(self, "scale", normal_scale, 1.0)
	tween.set_trans(Tween.TRANS_CUBIC).tween_property(self, "position", posCenter, 1.0)
	tween.set_trans(Tween.TRANS_CUBIC).tween_property(self, "modulate:a", 1.0, 1.0)
	tween.finished.connect(_on_tween_finished)

func _center_left() -> void:
	tween = create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_CUBIC).tween_property(self, "scale", final_scale, 1.0)
	tween.set_trans(Tween.TRANS_CUBIC).tween_property(self, "position", posLeft, 1.0)
	tween.set_trans(Tween.TRANS_CUBIC).tween_property(self, "modulate:a", 0.0, 1.0)
	tween.finished.connect(_on_tween_finished)

func _on_tween_finished():
	is_tweening = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_LMB") and is_tweening == false:
		is_tweening = true
		position = posRight
		_right_center()
	if event.is_action_pressed("ui_RMB") and is_tweening == false:
		is_tweening = true
		_center_left()
