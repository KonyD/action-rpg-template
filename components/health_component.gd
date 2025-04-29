extends Node
class_name HealthComponent

signal died

@export var health: int = 1
@export var hurtBox: HurtBoxComponent

func _ready() -> void:
	hurtBox.damageTaken.connect(damageTaken)

func damageTaken(damage: int) -> void:
	health -= damage
	if health <= 0:
		died.emit()
