extends Label  # or any other node with a shader

var time = 0.0

func _process(delta):
	time += delta
	material.set_shader_parameter("time", time)
