extends Control

signal opened
signal closed

var isOpen: bool = false

@onready var inventory: Inventory = preload("res://scripts/inventory/playerInventory.tres")
@onready var itemStackGuiClass = preload("res://scenes/itemStackGui.tscn")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready() -> void:
	connectSlots()
	inventory.updated.connect(update)
	update()

func connectSlots():
	for slot in slots:
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot: InventorySlot = inventory.slots[i]
		
		if !inventorySlot.item: continue
		
		var itemStackGui: ItemStackGui = slots[i].itemStackGui
		if !itemStackGui:
			itemStackGui = itemStackGuiClass.instantiate()
			slots[i].insert(itemStackGui)
		
		itemStackGui.inventorySlot = inventorySlot
		itemStackGui.update()

func open():
	visible = true
	isOpen = true
	opened.emit()

func close():
	visible = false
	isOpen = false
	closed.emit()

func onSlotClicked(slot):
	pass
