extends AnimatedSprite2D

var rotation_speed = 40
var speed = 10

func _physics_process(delta):
	rotation_degrees += rotation_speed * delta
	position.y -= speed * delta
