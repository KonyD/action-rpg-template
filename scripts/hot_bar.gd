extends Panel

@onready var inventory: Inventory = preload("res://scripts/inventory/playerInventory.tres")
@onready var slots: Array = $Container.get_children()
@onready var selector: Sprite2D = $Selector

var currrently_selected: int = 0

func _ready() -> void:
	update()
	inventory.updated.connect(update)

# Updates the UI to reflect the current state of the inventory.
func update() -> void:
	for i in range(slots.size()):
		var inventory_slot: InventorySlot = inventory.slots[i]
		slots[i].update_to_slot(inventory_slot)

# Moves the selector to the next slot, looping back to the first slot if necessary.
func move_selector():
	currrently_selected = (currrently_selected + 1) % slots.size()
	selector.global_position = slots[currrently_selected].global_position

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("use_item"):
		var selected_item = inventory.slots[currrently_selected].item # Get the item in the currently selected slot
		if selected_item.consumable == true:
			inventory.useItemAtIndex(currrently_selected)
		else: # If the item is not consumable, toggle its equipped state
			if selected_item.isEquiped():
				inventory.tabbedOutOfIndex(currrently_selected) # Unequip the item.
			else:
				inventory.tabbedIntoIndex(currrently_selected) # Equip the item.
			
			update() # Refresh the UI to reflect the change.

	if event.is_action_pressed("move_selector"):
		move_selector()
