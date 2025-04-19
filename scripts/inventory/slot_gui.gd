extends Button

@onready var backgroundSprite: Sprite2D = $Background
@onready var container: CenterContainer = $CenterContainer

var itemStackGui: ItemStackGui

func insert(isg: ItemStackGui):
	itemStackGui = isg
	backgroundSprite.frame = 1
	container.add_child(itemStackGui)
