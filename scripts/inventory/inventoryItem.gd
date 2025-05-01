extends Resource

class_name  InventoryItem

@export var name: String = ""
@export var texture: Texture2D
@export var maxAmount: int
@export var consumable: bool = true

var equiped = false

func use(player: Player) -> void:
	pass

func canBeUsed(player: Player) -> bool:
	return true

func equip(player: Player) -> void:
	pass

func unequip(player: Player) -> void:
	pass

func isEquiped() -> bool:
	return equiped
