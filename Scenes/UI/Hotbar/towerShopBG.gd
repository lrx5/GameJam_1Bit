extends TextureRect

@export var shopGrid 		: GridContainer
@export_range(0,20,0.5,"or_greater") var bgPadding : float ##Padding of the background texture


func _ready():
	if shopGrid:
		size	 = shopGrid.size + Vector2(bgPadding,bgPadding)
		position = shopGrid.position - Vector2(shopGrid.rightOffset*1.5,0)
