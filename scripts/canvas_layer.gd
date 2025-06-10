extends CanvasLayer

@onready var inventory: Control = $InventoryGui
@onready var settings_menu: Control = $SettingsMenu

func _ready() -> void:
	inventory.close()
	settings_menu.close()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		if inventory.isOpen:
			inventory.close()
		else:
			settings_menu.close()
			inventory.open()
	elif event.is_action_pressed("toggle_settings"):
		if settings_menu.isOpen and !inventory.isOpen:
			settings_menu.close()
		else:
			inventory.close()
			settings_menu.open()
