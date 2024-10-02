extends Panel

func set_panel_center_at_zero(panel: Control, width: float, height: float):
	# Set anchors to the center (0.5)
	anchor_left = 0.5
	anchor_right = 0.5
	anchor_top = 0.5
	anchor_bottom = 0.5

	# Calculate margin offset to account for odd sizes
	var margin_offset_x = 0.5 if roundi(width) % 2 == 1 else 0.0
	var margin_offset_y = 0.5 if roundi(height) % 2 == 1 else 0.0

	# Set margins so that the center of the panel is exactly at (0, 0)
	offset_left = -width / 2 - margin_offset_x
	offset_right = width / 2 - margin_offset_x
	offset_top = -height / 2 - margin_offset_y
	offset_bottom = height / 2 - margin_offset_y
