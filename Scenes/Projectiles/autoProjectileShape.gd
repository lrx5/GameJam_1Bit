class_name AutoProjectileShape
extends CollisionShape2D

@export var projectileSprite 	: Sprite2D
@export var screenMonitor 		: VisibleOnScreenNotifier2D
@export var hitbox				: CollisionShape2D
@onready var myShape = shape

func _ready():
	var projectileSpriteW = projectileSprite.get_rect().size.x
	var projectileSpriteH = projectileSprite.get_rect().size.y
	var hitboxShape = hitbox.shape
	hitboxShape.radius = ((projectileSpriteW * 2) - 1 )/2
	hitboxShape.height = projectileSpriteH + 1
	myShape.size = Vector2(projectileSpriteW,projectileSpriteH)
	screenMonitor.rect = Rect2(-10,-10,projectileSpriteW,projectileSpriteH)
