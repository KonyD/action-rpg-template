extends Resource

class_name  InventoryItem

@export var name: String = ""
@export var texture: Texture2D
@export var maxAmount: int

func use(player: Player) -> void:
	pass

func canBeUsed(player: Player) -> bool:
	return true
