extends Control

signal opened
signal closed

@onready var fullscreen_check_box: CheckBox = $NinePatchRect/VBoxContainer/HBoxContainer/FullscreenCheckBox
@onready var volume_slider: HSlider = $NinePatchRect/VBoxContainer/VBoxContainer/VolumeSlider

@export var bus_name: String
var bus_index: int
var isOpen: bool = false

var settings = {
	"fullscreen": false,
	"volume": 1
}
var json_path = "res://savedFiles/settings.json"

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	load_settings()

func open():
	load_settings()
	visible = true
	isOpen = true
	opened.emit()

func close():
	visible = false
	isOpen = false
	closed.emit()

func save_settings():
	var file = FileAccess.open(json_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(settings))
	file.close()
	file = null

func load_settings():
	var file = FileAccess.open(json_path, FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	
	settings = content
	
	fullscreen_check_box.button_pressed = settings.get("fullscreen", false)
	volume_slider.value = settings.get("volume", 1.0)

func _on_fullscreen_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	settings["fullscreen"] = toggled_on
	save_settings()


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	settings["volume"] = value
	save_settings()
