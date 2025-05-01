extends InventoryItem
class_name WeaponItem

@export var weapon_class: PackedScene = preload("res://scenes/player/sword.tscn")
var weapon

func _init() -> void:
	weapon = weapon_class.instantiate()

func use(player: Player) -> void:
	player.weapon.add_weapon(weapon)

func equip(player: Player) -> void:
	equiped = true
	player.weapon.add_weapon(weapon)

func unequip(player: Player) -> void:
	equiped = false
	player.weapon.remove_weapon()
