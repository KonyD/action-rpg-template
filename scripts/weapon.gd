extends Node2D

var weapon: Area2D

func _ready() -> void:
	if get_children().is_empty(): return
	
	weapon = get_children()[0]

func enable():
	if !weapon: return
	
	visible = true
	weapon.enable()

func disable():
	if !weapon: return
	
	visible = false
	weapon.disable()


func add_weapon(new_weapon) -> void:
	if weapon && weapon.name == new_weapon.name: return
	
	if weapon:
		remove_child(weapon)
	
	weapon = new_weapon
	add_child(new_weapon)
	
	disable()

func remove_weapon() -> void:
	if !weapon: return
	
	remove_child(weapon)
	weapon = null
