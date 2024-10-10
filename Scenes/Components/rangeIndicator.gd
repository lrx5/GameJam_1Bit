extends Panel

@onready var AR = get_parent()
@onready var sb = StyleBoxFlat.new()

func _process(delta: float) -> void:
	if AR.attackRange*2 != size.x:
		size.x = AR.attackRange * 2
		size.y = AR.attackRange * 2
		position.x = -AR.attackRange
		position.y = -AR.attackRange
		sb.border_color = Color(255, 255, 255)  # Border color
		sb.border_width_top = 1
		sb.border_width_bottom = 1
		sb.border_width_left = 1
		sb.border_width_right = 1
		sb.corner_radius_top_left = AR.attackRange
		sb.corner_radius_top_right = AR.attackRange
		sb.corner_radius_bottom_left = AR.attackRange
		sb.corner_radius_bottom_right = AR.attackRange
		sb.draw_center = false
		add_theme_stylebox_override("panel",sb)

	
