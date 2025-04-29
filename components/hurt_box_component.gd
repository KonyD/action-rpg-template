extends Node
class_name HurtBoxComponent

signal damageTaken(damage: int)

@export var area2D: Area2D

func _ready() -> void:
	area2D.area_entered.connect(collision)

# TODO: Fix error "E 0:00:15:451   emit_signalp: Error calling from signal 'area_entered' to callable: 'Node(hurt_box_component.gd)::collision': Method expected 0 arguments, but called with 1."

func collision(_area: Area2D) -> void:
	damageTaken.emit(1)
