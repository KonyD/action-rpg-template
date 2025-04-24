extends HBoxContainer

@onready var inventory: Inventory = preload("res://scripts/inventory/playerInventory.tres")
@onready var slots: Array = get_children()

func _ready() -> void:
	update()
	inventory.updated.connect(update)

func update() -> void:
	for i in range(slots.size()):
		var inventory_slot: InventorySlot = inventory.slots[i]
		slots[i].update_to_slot(inventory_slot)
