extends Panel

class_name ItemStackGui

@onready var itemSprite: Sprite2D = $Item
@onready var label: Label = $Label

var inventorySlot: InventorySlot 

func update():
	if !inventorySlot || !inventorySlot.item: return
	
	itemSprite.visible = true
	itemSprite.texture = inventorySlot.item.texture
	label.visible = inventorySlot.amount > 1
	label.text = str(inventorySlot.amount)
