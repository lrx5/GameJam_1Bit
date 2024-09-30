extends AnimatedSprite2D

var speed = 10
var rotation_speed = 40

func _process(delta):

	rotation_degrees += rotation_speed * delta
	position.y -= speed * delta
