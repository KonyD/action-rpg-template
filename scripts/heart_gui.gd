extends Panel

@onready var sprite: Sprite2D = $Sprite2D

func update(fraction: int):
	match fraction:
		0: sprite.frame = 0
		1: sprite.frame = 1
		2: sprite.frame = 2
		3: sprite.frame = 3
		4: sprite.frame = 4
