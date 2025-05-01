extends Node
class_name HurtBoxComponent

signal damageTaken(damage: int)

@export var area2D: Area2D

func _ready() -> void:
	area2D.area_entered.connect(collision)

func collision(_area: Area2D) -> void:
	damageTaken.emit(1)
