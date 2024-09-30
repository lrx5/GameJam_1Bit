extends Sprite2D


var speed = 10

func _physics_process(delta):
	position.y -= speed * delta
