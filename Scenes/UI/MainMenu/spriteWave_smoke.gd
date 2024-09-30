extends TextureRect  # or any other node with a shader

var time = 0.0

func _ready() -> void:
	#Set Shader Variables
	material.set_shader_parameter("amplitude", 5.0)
	material.set_shader_parameter("frequency", 10.0)
func _process(delta):
	time += delta 
	material.set_shader_parameter("time", time)
