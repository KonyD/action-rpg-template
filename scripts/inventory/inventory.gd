extends Resource

class_name Inventory

signal updated
signal use_item

@export var slots: Array[InventorySlot]
var index_of_last_used_item: int = -1

func insert(item: InventoryItem):
	for slot in slots:
		if slot.item == item:
			if slot.amount >= item.maxAmount:
				continue
			slot.amount += 1
			updated.emit()
			return
	
	for i in range(slots.size()):
		if !slots[i].item:
			slots[i].item = item
			slots[i].amount += 1
			updated.emit()
			return

func removeSlot(inventorySlot: InventorySlot):
	var index = slots.find(inventorySlot)
	if index < 0: return
	
	removeAtIndex(index)

func removeAtIndex(index: int) -> void:
	slots[index] = InventorySlot.new()
	updated.emit()

func insertSlot(index: int, inventorySlot: InventorySlot):
	slots[index] = inventorySlot
	updated.emit()

func hasItem(item_name: String) -> bool:
	for slot in slots:
		if slot.item and slot.item.name == item_name:
			return true
	
	return false

func useItemAtIndex(index: int) -> void:
	if index < 0 || index >= slots.size() || !slots[index].item: return
	
	var slot = slots[index]
	index_of_last_used_item = index
	use_item.emit(slot.item)

func removeLastUsedItem() -> void:
	if index_of_last_used_item < 0: return
	var slot = slots[index_of_last_used_item]
	
	if slot.amount > 1:
		slot.amount -= 1
		updated.emit()
		return
	
	removeAtIndex(index_of_last_used_item)
